### 知识点

#### UITableView风格

```
typedef NS_ENUM(NSInteger, UITableViewStyle) {
    UITableViewStylePlain,                  // regular table view
    UITableViewStyleGrouped                 // preferences style table view
};

后者按分组样式显示前者按照普通样式显示
```

#### UITableViewCell

TableView中每行数据都是一个UITableViewCell。

在UITableViewCell中有多个子控件供开发者调用：

```
一个UIView控件（contentView，作为其他元素的父控件）作为容器
两个UILable控件（textLabel、detailTextLabel）显示内容和详情
一个UIImage控件（imageView）显示图片
```
上述4个控件是已经被创建，因此只需要对其值进行修改即可。此外，还有一个UIView控件（accessoryView），作为访问起存在，并没有被创建，如果开发者需要使用此属性，需要先自己创建一个控件和此属性关联起来。

设置访问器可以通过accessoryType属性设置成默认给予的几种访问器类型，也可以通过accessoryView进行自定义控件的设置。

对这些空间的显示进行定制的枚举：UITableViewCellStyle

```
typedef NS_ENUM(NSInteger, UITableViewCellStyle) {
    UITableViewCellStyleDefault,    // 左侧显示textLabel（不显示detailTextLabel），imageView可选（显示在最左边）
    UITableViewCellStyleValue1,     // 左侧显示textLabel、右侧显示detailTextLabel（默认灰色），imageView可选（显示在最左边）
    UITableViewCellStyleValue2,     // 左侧依次显示textLabel(默认蓝色)和detailTextLabel，imageView可选（显示在最左边）
    UITableViewCellStyleSubtitle    // 左上方显示textLabel，左下方显示detailTextLabel,imageView可选（显示在最左边）
};
```

#### UITableViewCell的创建

```
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)
```

+ 此方法调用很频繁，无论是初始化、上下滚动、刷新都会调用此方法，所以在这里执行的操作一定要注意性能；

+ 可重用标识可以有多个，如果在UITableView中有多类结构不同的Cell，可以通过这个标识进行缓存和重新；