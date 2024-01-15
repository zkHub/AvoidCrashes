# AvoidCrashes

[![CI Status](https://img.shields.io/travis/zhangke/AvoidCrashes.svg?style=flat)](https://travis-ci.org/zhangke/AvoidCrashes)
[![Version](https://img.shields.io/cocoapods/v/AvoidCrashes.svg?style=flat)](https://cocoapods.org/pods/AvoidCrashes)
[![License](https://img.shields.io/cocoapods/l/AvoidCrashes.svg?style=flat)](https://cocoapods.org/pods/AvoidCrashes)
[![Platform](https://img.shields.io/cocoapods/p/AvoidCrashes.svg?style=flat)](https://cocoapods.org/pods/AvoidCrashes)

## 简介

这个项目是对iOS项目（OC）常见的崩溃做一些容错，避免应用运行时闪退，提升用户的体验。
目前主要使用Runtime机制，来防止如下崩溃的发生，并支持回调记录和DEBUG下的Log提示：
- NSArray,NSMutableArray,NSDictionary,NSMutableDictionary等集合类及其可变子类的常见操作导致的崩溃。
- unrecognized selector sent to instance/class

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AvoidCrashes is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AvoidCrashes'
```

## Author

zhangke, 192938268@qq.com

## License

AvoidCrashes is available under the MIT license. See the LICENSE file for more info.
