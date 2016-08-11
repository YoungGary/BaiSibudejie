//
//  GYSeeBigImageViewController.m
//  Budejie
//
//  Created by YOUNG on 16/8/11.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "GYSeeBigImageViewController.h"
#import "GYTopicModel.h"

#import <Photos/Photos.h>

#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface GYSeeBigImageViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property(nonatomic,weak)UIImageView *imageView;

/** 当前App对应的自定义相册 */
- (PHAssetCollection *)createdCollection;
/** 返回刚才保存到【相机胶卷】的图片 */
- (PHFetchResult<PHAsset *> *)createdAssets;
@end

@implementation GYSeeBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [scrollView addGestureRecognizer:tap];
   // scrollView.frame = self.view.bounds;
   // scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:scrollView atIndex:0];
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.saveButton.enabled = YES;
    }];
    
    imageView.userInteractionEnabled = YES;
    imageView.gy_x = 0;
    imageView.gy_width = scrollView.gy_width;
    imageView.gy_height  = imageView.gy_width * self.model.height/self.model.width;
    if (self.model.height > ScreenHeight) {//大图
        imageView.gy_y = 0;
        //imageView.gy_height = self.model. height;
        scrollView.contentSize = CGSizeMake(0, imageView.gy_height);
    }else{//小图
        imageView.gy_centerY = scrollView.gy_height/2;
    }
    [scrollView addSubview:imageView ];
    self.imageView = imageView;
    //图片缩放
    CGFloat maxScale = self.model.height/imageView.gy_height;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

-(void)dismiss{
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 获得当前App对应的自定义相册
- (PHAssetCollection *)createdCollection
{
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }
    
    /** 当前App对应的自定义相册没有被创建过 **/
    // 创建一个【自定义相册】
    NSError *error = nil;
    __block NSString *createdCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionID] options:nil].firstObject;
}
#pragma mark -- 保存照片到相机胶卷 并且获取这张照片
- (PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    __block NSString *assetID = nil;
    
    // 保存图片到【相机胶卷】
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    // 获取刚才保存的相片
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}




- (IBAction)sava:(id)sender {//save to album
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    // 请求\检查访问权限 :
    // 如果用户还没有做出选择，会自动弹框，用户对弹框做出选择后，才会调用block
    // 如果之前已经做过选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前App访问相册
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    NSLog(@"提醒用户打开开关");
                }
            } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前App访问相册
                [self saveImageIntoAlbum];
            } else if (status == PHAuthorizationStatusRestricted) { // 无法访问相册
                [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
            }
        });
    }];

}

- (void)saveImageIntoAlbum{
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
        return;
    }
    
    // 获得相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败！"];
        return;
    }
    
    // 添加刚才保存的图片到【自定义相册】
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    // 最后的判断
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功！"];
    }

}

#pragma mark -- UIScrollViewDelegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
