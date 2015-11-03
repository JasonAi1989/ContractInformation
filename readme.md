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

#### UITableViewCell的修改

这里所说的修改包括删除cell，添加cell以及移动cell，如果想修改cell中的详细信息，可以通过弹出交互界面的方式（如一个新的UIView页面或者UIAlertView页面等）进行修改。

需要被调用的方法：

```
//开启或者关闭编辑模式，第二个参数是切换模式时是否有动画效果
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
```

代理中需要实现的方法：

```
//返回一个编辑模式的风格，可以是删除风格的编辑模式，也可以是添加风格的编辑模式，默认不实现此方法为删除风格的编辑模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
```

数据源中需要实现的方法：

```
//具体去实现添加或者删除的功能，注意，要想修改UI，先修改数据模型
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

// 实现拖动cell的功能，这里主要通过第二和第三个参数对数据模型进行修改，不需要再调用刷新方法。
// 不管是添加还是删除风格的编辑模式，只要实现了此函数，均可以实现拖动功能
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
```

下面是关于刷新cell的方法。注意，下列方法的第一个参数是NSIndexPath类型的数组，也就是说，一次可以刷新多个位置的cell。

```
//添加时刷新指定的行，注意，在数据模型中新添加的数据应该在对应的indexPath位置，这样使用此方法才能将新添加的数据刷新到UI中
- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

//删除时刷新指定的行，同样，先修改数据模型，然后调用此方法
- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

//当修改完某个cell的详细信息后可以使用此方法只刷新单个cell
- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:

//刷新这个表，这样做性能会较差，如果是需要删除表中某个组时可以使用此方法
- (void)reloadData;
```

关于NSIndexPath类型，在UITableView部分需要记住的有两个关键值：

```
@interface NSIndexPath (UITableView)

+ (NSIndexPath *)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@property(nonatomic,readonly) NSInteger section; // 代表表中的组号
@property(nonatomic,readonly) NSInteger row;   // 代表组中的行号

@end
```
这两个属性都是只读类型，需要通过构造函数对其进行赋值。

#### UITableView + UIViewController <= UITableViewController

如果一个页面中只有一个UITableView控件的话，可以直接使用UITableViewController。这个控制器 UITableViewController实现了UITableView数据源和代理协议，内部定义了一个tableView属性供外部访问，同时自动铺满整个屏幕、自动伸缩以方便我们的开发。当然UITableViewController也并不是简单的帮我们定义完UITableView并且设置了数据源、代理而已，它还有其他强大的功能，例如刷新控件、滚动过程中固定分组标题等。

### 总结
+ UITableVIew拥有两种风格，默认和带组的；
+ 数据源中有必需实现的两个方法，分别用于计算表的行数和生成cell；
+ 设置行高、行首高和注脚高需要再代理中实现；
+ 与点击行相关的操作也要在代理中实现；
+ 设置组数量、行首和注脚标题、右侧字母索引、添加、删除和移动cell的实际动作都可以在数据源中实现；
+ 尽量使用cell重用机制；
+ 尽量使用单个cell的刷新来代替整个表的刷新；
+ 如果页面中只有UITableVIew一个控件，尽量使用UITableViewController；
+ 如果要使用searchBar，最好配合UISearchController控件进行使用；
+ 当实现搜索功能时，将字符全部转换成大写（或者小写）可以实现忽略大小写的过滤；
+ NSIndexPath中的section代表表中组id，row代表组中行id；
+ cell 中包涵一个UIView控件，两个UILable控件，一个UIImage控件；
+ 可通过设置cell中的accessoryView或者accessoryType来自定义或选择cell的访问器；
+ 可以通过给cell中的UIView控件添加子控件的方式来自定义一个cell的样式；

表创建过程图：

![create table](http://7xj4cp.com1.z0.glb.clouddn.com/create_table.jpg)

cell删除、添加和移动的过程图：

![modify the cell](http://7xj4cp.com1.z0.glb.clouddn.com/modify_cell.jpg)


### 项目效果图

<video id="video" controls="" preload="auto" loop="loop" height="460" width="750">
      <source id="mp4" src="http://7xj4cp.com1.z0.glb.clouddn.com/ContactInfo.mp4" type="video/mp4">
      <p>Your user agent does not support the HTML5 Video element.</p>
</video>
