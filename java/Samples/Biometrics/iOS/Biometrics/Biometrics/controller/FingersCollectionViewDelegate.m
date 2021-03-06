#import "FingersCollectionViewDelegate.h"
#import "DBCategoryCell.h"
#import "DBEmptyCell.h"
#import "FaceController.h"

@implementation FingersCollectionViewDelegate

-(void)setupDelegateWithViewController:(DatabaseController*)viewControllerArg{
    [super setupDelegateWithViewController:viewControllerArg];
    [self reloadData];
}

-(HNSubject)getSubjectAtIndex:(int)index{
    if ((index >= 0) && (index <= fingers.count-1)){
        BiometricsResource *resource = [fingers objectAtIndex:index];
        return resource.subject;
    }
    return NULL;
}
-(void)reloadData{
    fingers = [[BiometricsLayer sharedInstance] getAllSubjectsWithPrefix:PREFIX_FINGER];
    [viewController.collectionView reloadData];
}

//CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return fingers.count>0?fingers.count:1;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (fingers.count == 0) return UIEdgeInsetsZero;
    return UIEdgeInsetsMake(30, 0, 30, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionViewArg layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (fingers.count == 0){
        return CGSizeMake(collectionViewArg.frame.size.width, collectionViewArg.frame.size.height-collectionViewArg.contentInset.top-collectionViewArg.contentInset.bottom);
    }
    return CGSizeMake(collectionViewArg.frame.size.width, [DBCategoryCell heightForCell]);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionViewArg cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (fingers.count == 0){
        return [collectionViewArg dequeueReusableCellWithReuseIdentifier:@"DBEmptyCell" forIndexPath:indexPath];
    }
    Finger *finger = [fingers objectAtIndex:indexPath.row];
    DBCategoryCell *cell = [collectionViewArg dequeueReusableCellWithReuseIdentifier:@"DBCategoryCell" forIndexPath:indexPath];
    UICollectionViewCellType cellType = UICollectionViewCellTypeMiddle;
    int itemsCount = (int)[self collectionView:collectionViewArg numberOfItemsInSection:indexPath.section];
    if (itemsCount == 1) cellType = UICollectionViewCellTypeFirstAndLast;
    else if (indexPath.row == itemsCount-1) cellType = UICollectionViewCellTypeLast;
    else if (indexPath.row == 0) cellType = UICollectionViewCellTypeFirst;
    [cell setupCellWithTitle:finger.name andImage:[finger getImage] andType:cellType canDelete:viewController.navigationController.viewControllers.count>1];
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:viewController action:@selector(deleteSubjectClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (fingers.count == 0) return;
    Finger *finger = [fingers objectAtIndex:indexPath.row];
    [[BiometricsLayer sharedInstance] fillSubjectWithAttributes:finger.subject];
    if ([viewController.delegate respondsToSelector:@selector(databaseController:didChooseFinger:)]){
        [viewController.delegate databaseController:viewController didChooseFinger:finger];
    }
}
@end
