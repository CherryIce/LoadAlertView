//
//  ICEWKWeViewController.h
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEBaseViewController.h"

#define POST_JS @"function my_post(path, params) {\
var method = \"POST\";\
var form = document.createElement(\"form\");\
form.setAttribute(\"method\", method);\
form.setAttribute(\"action\", path);\
for(var key in params){\
if (params.hasOwnProperty(key)) {\
var hiddenFild = document.createElement(\"input\");\
hiddenFild.setAttribute(\"type\", \"hidden\");\
hiddenFild.setAttribute(\"name\", key);\
hiddenFild.setAttribute(\"value\", params[key]);\
}\
form.appendChild(hiddenFild);\
}\
document.body.appendChild(form);\
form.submit();\
}"

NS_ASSUME_NONNULL_BEGIN

@interface ICEWKWeViewController : ICEBaseViewController

//传参 ==== xxxxxx ====
@property (nonatomic , copy) NSString * url;

//传参 ==== xxxxxx ====

//传参 ==== xxxxxx ====

@end

NS_ASSUME_NONNULL_END
