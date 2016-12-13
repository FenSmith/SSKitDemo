**SSService是用于[SSKit](https://github.com/bassamyan/SSKit)的一个小组件,其本身作用单独作用不大,需要配合SSKit使用**

<u>结构：</u>

- SSService
- SSLocationService(未完成)
- SSRequestService

<u>其他联合组件：</u>

- SSHandler

<u>SSRequestService基本用法：</u>

```
- (RACSignal *)requestCommunityCommentsAttachPage:(NSInteger)page {
return [[SSRequestService sharedRequest] requestPOSTWithURL:@"community/comments" alsoParams:@{@"page":@(page)}];
}
```

```
- (RACSignal *)submitUserAvatarImageWithImage:(UIImage *)avatarImage {
return [[SSRequestService sharedRequest] submitImageWithURL:@"user/change_avator" alsoImage:avatarImage alsoImageName:@"avator"];
}
```

