# VPGenericCollectionView

[![CI Status](https://img.shields.io/travis/varunpm1/VPGenericCollectionView.svg?style=flat)](https://travis-ci.org/varunpm1/VPGenericCollectionView)
[![Version](https://img.shields.io/cocoapods/v/VPGenericCollectionView.svg?style=flat)](https://cocoapods.org/pods/VPGenericCollectionView)
[![License](https://img.shields.io/cocoapods/l/VPGenericCollectionView.svg?style=flat)](https://cocoapods.org/pods/VPGenericCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/VPGenericCollectionView.svg?style=flat)](https://cocoapods.org/pods/VPGenericCollectionView)


# Why?
If you're an iOS developer with couple of years of experience (like me), I can guarantee that you'll be tired with writing same set of code for initializing the collection view and it's cells. And when we plan to think of auto resizing cells (or self-sizing cells), it becomes pretty frustrating to write same/similar code in all places. This library, makes use of generics to write code once (which is already written inside this library 😉) and use multiple times.


# How?
VPGenericCollectionView uses a protocol based approach, to create a homogeneous collection view with auto resizing cells and handling, with very less code. VPGenericCellProtocol is a protocol defines on how the cell has to be constructed and GenericCollectionView requires cells to confirm to those protocol to work. You'll see compiler errors if you're doing something wrong and it'll inform about the error.


# Set up?
**Setting up VPGenericCollectionView**
- Declare a property of GenericCollectionView with cell class inside Generic parameters and initialize it normally. That cell should COMPULSORILY confirm to VPGenericCellProtocol.
- Set the frame / constraints normally to the parent view as we do for any other views.
- Set `maximumCellWidth`, which is the max width the cell can take.
- Whenever we have necessary data, call `reload:` function of GenericCollectionView instance, to update collection view.
- Optional - Set `minimumCellHeight` to appropriate value based on cell's minimum content. i.e., if a cell has image view of height 100 and 2 labels placed below image view with 8 pixel padding between each other, then minimum cell's height will be 8 + 100 + 8 + 0 (since label can be empty and it can take 0 as height without breaking constraints) + 8 = 124. It can be slightly above say, 125 in this case. 

But setting to large value (eg., 250 here) will render all cells to at least that value, i.e., even if cell doesn't have content, it'll be rendered at 250. 

If we set value below 124, the cell will throw constraint errors and behaviour is not known.

```

/* Cell's layout */

|-----------------|
|        8        |
|-----------------|  _
|                 |  |
|    ImageView    | 100
|                 |  |
|-----------------|  -
|        8        |
|-----------------|
|                 |
|      Label      |
|                 |
|-----------------|
|        8        |
|-----------------|


```

- Optional - Modify optional parameters like cellSpacing, color, insets etc as needed.
- Optional - Set `configureCellCallback`, if cell has to be configured more other than default setup we do inside collection view cells (eg., hide or unhide buttons etc.). This will be called as soon as cellForRow is completed viewModel is initialized. The parameter inside the callback will be type casted automatically using generics.
- Optional - Set `didSelectCallback`, if cell tap selection has to be observed. The parameter inside the callback will be type casted automatically using generics.


**Setting up Collection View Cell**
- You'll be forced to define a `viewModel` property inside your cell. Declare the property with your object data type and update your views inside `didSet` of that variable which will be automatically called.
- Add subviews for cell normally but make sure that we have either four sided constraints inside the cell for any view so that we can determine the cell's content height properly.


**Cons** - Doesn't support setup of VPGenericCollectionView via nib files. VPGenericCollectionView has to be created via code. But since creation is easier, I think we can ignore this.


**Note 1** - If you need a resizable collection view cells in a small expandable view, eg. Action Sheet, add the instance of VPGenericCollectionView inside a stack view and add four side constraints to Stack View and you'll be set.

**Note 2** - If you need a resizable collection view cells inside another resizable collection view cells (layer of hierarchy of VPGenericCollectionView), add it just like mentioned in **Note 1**, i.e., add a stack view inside parent cell.



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

VPGenericCollectionView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'VPGenericCollectionView'
```

## Author

varunpm1, varun.pm1@gmail.com

## License

VPGenericCollectionView is available under the MIT license. See the LICENSE file for more info.
