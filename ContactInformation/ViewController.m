//
//  ViewController.m
//  ContactInformation
//
//  Created by jason on 15/11/2.
//  Copyright (c) 2015年 JasonAi. All rights reserved.
//

#import "ViewController.h"
#import "ContactInfo.h"

#define ToolBarHeight 40
#define SearchBarHeight 40

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UISearchBarDelegate>{
    UITableView* _tableView;
    NSMutableArray* _contacts; //记录ContactGroup
    NSIndexPath* _selectedCell;
    UIToolbar* _toolBar;
    BOOL _isAdd;
    
    //for search
    UISearchBar* _searchBar;
    NSMutableArray* _searchResult;
    BOOL _isSearching;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.origin.y += ToolBarHeight;
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    [self addToolBar];
    
    [self addSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 自已定义的方法
//初始化 _contacts 中的联系人数据
- (void)initData
{
    ContactInfo *contactA1 = [[ContactInfo alloc] initWithFirstName:@"Ai" andLastName:@"Jason" andPhoneNumber:@"18301005476"];
    ContactInfo *contactA2 = [[ContactInfo alloc] initWithFirstName:@"Ai" andLastName:@"Xue" andPhoneNumber:@"15230937239"];
    NSMutableArray *arrayA = [[NSMutableArray alloc] initWithObjects:contactA1, contactA2, nil];
    ContactGroup *groupA = [[ContactGroup alloc] initWithGroupName:@"A" andGroupDetail:@"姓以A字开头的联系人" andContactInfos:arrayA];
    
    ContactInfo *contactB1 = [[ContactInfo alloc] initWithFirstName:@"Ban" andLastName:@"Wenbao" andPhoneNumber:@"15652965004"];
    ContactInfo *contactB2 = [[ContactInfo alloc] initWithFirstName:@"Belle" andLastName:@"" andPhoneNumber:@"18500606488"];
    NSMutableArray *arrayB = [[NSMutableArray alloc] initWithObjects:contactB1, contactB2, nil];
    ContactGroup *groupB = [[ContactGroup alloc] initWithGroupName:@"B" andGroupDetail:@"姓以B字开头的联系人" andContactInfos:arrayB];
    
    ContactInfo *contactC1 = [[ContactInfo alloc] initWithFirstName:@"Cao" andLastName:@"Xueliang" andPhoneNumber:@"13167311228"];
    ContactInfo *contactC2 = [[ContactInfo alloc] initWithFirstName:@"Chai" andLastName:@"Jinling" andPhoneNumber:@"15116905114"];
    ContactInfo *contactC3 = [[ContactInfo alloc] initWithFirstName:@"Chang" andLastName:@"Mengchun" andPhoneNumber:@"18811550543"];
    NSMutableArray *arrayC = [[NSMutableArray alloc] initWithObjects:contactC1, contactC2, contactC3, nil];
    ContactGroup *groupC = [[ContactGroup alloc] initWithGroupName:@"C" andGroupDetail:@"姓以C字开头的联系人" andContactInfos:arrayC];

    ContactInfo *contactL1 = [[ContactInfo alloc] initWithFirstName:@"Li" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    ContactInfo *contactL2 = [[ContactInfo alloc] initWithFirstName:@"Li" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    ContactInfo *contactL3 = [[ContactInfo alloc] initWithFirstName:@"Li" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    ContactInfo *contactL4 = [[ContactInfo alloc] initWithFirstName:@"Li" andLastName:@"Lukas" andPhoneNumber:@"18500131249"];
    ContactInfo *contactL5 = [[ContactInfo alloc] initWithFirstName:@"Li" andLastName:@"keven" andPhoneNumber:@"18500131250"];
    ContactInfo *contactL6 = [[ContactInfo alloc] initWithFirstName:@"Li" andLastName:@"Rose" andPhoneNumber:@"18500131251"];
    NSMutableArray *arrayL = [[NSMutableArray alloc] initWithObjects:contactL1, contactL2, contactL3, contactL4, contactL5, contactL6, nil];
    ContactGroup *groupL = [[ContactGroup alloc] initWithGroupName:@"L" andGroupDetail:@"姓以L字开头的联系人" andContactInfos:arrayL];
    
    ContactInfo *contactW1 = [[ContactInfo alloc] initWithFirstName:@"Wang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    ContactInfo *contactW2 = [[ContactInfo alloc] initWithFirstName:@"Wang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    ContactInfo *contactW3 = [[ContactInfo alloc] initWithFirstName:@"Wang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    ContactInfo *contactW4 = [[ContactInfo alloc] initWithFirstName:@"Wang" andLastName:@"Lukas" andPhoneNumber:@"18500131249"];
    ContactInfo *contactW5 = [[ContactInfo alloc] initWithFirstName:@"Wang" andLastName:@"keven" andPhoneNumber:@"18500131250"];
    ContactInfo *contactW6 = [[ContactInfo alloc] initWithFirstName:@"Wang" andLastName:@"Rose" andPhoneNumber:@"18500131251"];
    NSMutableArray *arrayW = [[NSMutableArray alloc] initWithObjects:contactW1, contactW2, contactW3, contactW4, contactW5, contactW6, nil];
    ContactGroup *groupW = [[ContactGroup alloc] initWithGroupName:@"W" andGroupDetail:@"姓以W字开头的联系人" andContactInfos:arrayW];
    
    ContactInfo *contactZ1 = [[ContactInfo alloc] initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    ContactInfo *contactZ2 = [[ContactInfo alloc] initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    ContactInfo *contactZ3 = [[ContactInfo alloc] initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    ContactInfo *contactZ4 = [[ContactInfo alloc] initWithFirstName:@"Zhang" andLastName:@"Lukas" andPhoneNumber:@"18500131249"];
    NSMutableArray *arrayZ = [[NSMutableArray alloc] initWithObjects:contactZ1, contactZ2, contactZ3, contactZ4, nil];
    ContactGroup *groupZ = [[ContactGroup alloc] initWithGroupName:@"Z" andGroupDetail:@"姓以Z字开头的联系人" andContactInfos:arrayZ];
    
    _contacts = [[NSMutableArray alloc] initWithObjects:groupA, groupB, groupC, groupL, groupW, groupZ, nil];
}

- (void) addToolBar
{
    CGRect rect = self.view.frame;
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, ToolBarHeight)];
    
    UIBarButtonItem* removeBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeButton:)];

    UIBarButtonItem* addBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButton:)];

    //这个item用于分隔上面两个item
    UIBarButtonItem* spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //用一个数组存储所创建的几个button，toolBar中有一个属性items是数组类型了，用于关联button数组
    NSArray* btnArray = [[NSArray alloc]initWithObjects:removeBtn, spaceBtn, addBtn, nil];
    _toolBar.items = btnArray;
    
    [self.view addSubview:_toolBar];
    
//    _toolBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void) addSearchBar
{
    CGRect rect = self.view.frame;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, SearchBarHeight)];
    
//    _searchBar.placeholder = @"Please input key word...";
//    _searchBar.keyboardType = UIKeyboardTypeAlphabet;//键盘类型
//    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;//自动纠错类型
//    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;//哪一次shitf被自动按下
    _searchBar.showsCancelButton = YES;//显示取消按钮
    
    _searchBar.delegate = self;
    
    _tableView.tableHeaderView = _searchBar;
}

- (void) searchKeyWord:(NSString*) searchText
{
    if (searchText.length == 0) {
        _isSearching = false;
        return;
    }
    
    _isSearching = true;
    
    _searchResult = [NSMutableArray array];
    
    [_contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        ContactGroup* group = obj;
        
        [group.contactInfos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            ContactInfo* contact = obj;
            
            if ([contact.firstName.uppercaseString containsString:searchText.uppercaseString]
                || [contact.lastName.uppercaseString containsString:searchText.uppercaseString]
                || [contact.phoneNumber.uppercaseString containsString:searchText.uppercaseString])
            {
                [_searchResult addObject:contact];
            }
        }];
        
    }];
    
    [_tableView reloadData];
}

#pragma mark 自定义的事件处理函数
- (void) switchAction:(UISwitch*) sw
{
    NSLog(@"here");
}

- (void) removeButton:(id) sender
{
    if (_isSearching) {
        return;
    }
    
    _isAdd = false;
    [_tableView setEditing:!_tableView.isEditing animated:true];
}

- (void) addButton:(id) sender
{
    if (_isSearching) {
        return;
    }
    
    if (_isAdd == true)
    {
        _isAdd = false;
    }
    else
    {
        _isAdd = true;
    }
    
    [_tableView setEditing:!_tableView.isEditing animated:true];
}


#pragma mark UITableViewDataSource required
// 返回Table中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearching) {
        return _searchResult.count;
    }
    
    ContactGroup *group = _contacts[section];
    
    return group.contactInfos.count;
}

// 生成 UITableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 0 //for accessoryView
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier = @"contactInfo";
    static NSString *firstCellIdentifier = @"firstCellIdentifier";
    
    //先去cell池中取对象
    UITableViewCell* cell = nil;
    if (indexPath.row == 0) {
        cell = [_tableView dequeueReusableCellWithIdentifier:firstCellIdentifier];
    }
    else
    {
        cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    //如果cell池中没有可用的cell，再重新生成新的cell
    if (cell == nil) {
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:firstCellIdentifier];
            
            //创建UISwitch对象，用于和cell的访问器相关联
            UISwitch *sw = [[UISwitch alloc] init];
            
            //将UISwitch对象和self中的switchAction方法相关联，当碰到值改变的事件后进行跳转
            [sw addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            
            //将UISwitch对象和accessoryView访问器关联起来
            cell.accessoryView = sw;
        }
        else
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            
            //设置访问器的类型
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
        }
    }
    
    ContactGroup* group = _contacts[indexPath.section];
    ContactInfo* contact = group.contactInfos[indexPath.row];
    
#else  //for search code
    //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
    static NSString *cellIdentifier = @"contactInfo";
    
    //先去cell池中取对象
    UITableViewCell* cell = nil;
    cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //如果cell池中没有可用的cell，再重新生成新的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        //设置访问器的类型
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    
    NSLog(@"%d %ld %ld", _isSearching, indexPath.section, indexPath.row);
    ContactGroup* group = nil;
    ContactInfo* contact = nil;
    if (_isSearching == true) {
        contact = _searchResult[indexPath.row];
    }
    else
    {
        group = _contacts[indexPath.section];
        contact = group.contactInfos[indexPath.row];
    }
    
#endif

    //填充cell中的数据
    cell.textLabel.text = [contact getName];
    cell.detailTextLabel.text = [contact phoneNumber];
    
    return cell;
}

#pragma mark UITableViewDataSource optional
//Table中的分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearching) {
        return 1;
    }
    
    return _contacts.count;
}

//设置行首和注脚的内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_isSearching) {
        return @"Search Result:";
    }
    
    ContactGroup *group = _contacts[section];
    
    return group.groupName;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (_isSearching) {
        return nil;
    }
    
    ContactGroup *group = _contacts[section];
    
    return group.groupDetail;
}

// 生成右侧索引框
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexArray = [[NSMutableArray alloc] init];
    
    for (ContactGroup* group in _contacts) {
        [indexArray addObject:group.groupName];
    }
    
    return indexArray;
}

//实现了此方法向左滑动就会显示删除按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isSearching) {
        return;
    }
    
    ContactGroup* group = _contacts[indexPath.section];
    ContactInfo* contact = group.contactInfos[indexPath.row];
    
    //MVC的核心思想，要想修改UI，先修改数据
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [group.contactInfos removeObject:contact];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        //如果组里没有成员了要从_contacts中删除这个组成员，再刷新一下整个table，否则没有成员的那个组在UI上仍然会有header和footer
        if (group.contactInfos.count == 0) {
            [_contacts removeObject:group];
            [_tableView reloadData];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        ContactInfo* newContact = [[ContactInfo alloc] initWithFirstName:@"first" andLastName:@"last" andPhoneNumber:@"12345678901"];
        [group.contactInfos insertObject:newContact atIndex:indexPath.row];
        
        [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

//实现这个函数可实现编辑状态下cell的拖动，如果没有对数据做正确的修改，当table滑动时会产生崩溃现象，
//原因是控制器在模型中找寻数据时未找到。
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (_isSearching) {
        return;
    }

    ContactGroup* srcGroup = _contacts[sourceIndexPath.section];
    ContactInfo*  srcContact = srcGroup.contactInfos[sourceIndexPath.row];
    
    ContactGroup* dstGroup = _contacts[destinationIndexPath.section];
    
    [srcGroup.contactInfos removeObject:srcContact];
    
    if (srcGroup.contactInfos.count == 0) {
        [_contacts removeObject:srcGroup];
        [_tableView reloadData];
    }
    
    [dstGroup.contactInfos insertObject:srcContact atIndex:destinationIndexPath.row];
}

#pragma mark UITableViewDelegate optional
//分别设置每行，行首和注脚的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}

//设置行被选中后的动作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedCell = indexPath;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Modify Phone Number" message:@"This is a test" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    //弹出框的样式为可输入可见字符的弹出框
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    //获取输入框的句柄
    UITextField *textField = [alert textFieldAtIndex:0];
    
    //在输入框中填充当前的手机号
    ContactGroup *group = _contacts[indexPath.section];
    ContactInfo *contact = group.contactInfos[indexPath.row];
    textField.text = contact.phoneNumber;
    
    [alert show];
}

//客户化定制编辑效果————删除或者添加
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isAdd) {
        return UITableViewCellEditingStyleInsert;
    }
    
    return UITableViewCellEditingStyleDelete;
}

#pragma mark UIAlertViewDelegate optional
//UIAlertView 初始化所需要的协议方法，用来处理按钮按下后的动作
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //when buttonIndex is 'OK'
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        ContactGroup *group = _contacts[_selectedCell.section];
        ContactInfo *contact = group.contactInfos[_selectedCell.row];
        contact.phoneNumber = textField.text;
        
        //更新整个table的数据，不推荐这样操作
        //[_tableView reloadData];
        
        //只更新指定组中的指定行
        NSArray *indexPath = @[_selectedCell];
        [_tableView reloadRowsAtIndexPaths:indexPath withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark 重写状态栏
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark UISearchBarDelegate optional
// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0 && _isSearching == true) {
        _isSearching = false;
        [_tableView reloadData];
 
        return;
    }
    
    [self searchKeyWord:searchText];
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchKeyWord:searchBar.text];
    
    //放弃第一响应者对象，关闭虚拟键盘
    [_searchBar resignFirstResponder];
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _isSearching = false;
    searchBar.text = @"";
    
    [_tableView reloadData];
}
@end
