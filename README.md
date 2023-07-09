#### flutter版本

###### 3.0.1

#### 目录结构

    |-- main.dart 入口
    |
    |-- api 数据
    |
    |-- controllers // 公共Controller
    |   |-- parts
    |       |-- global_data_controller.dart // 全局数据
    |       |-- location_controller.dart // 位置发送
    |       |-- notification_controller.dart // 通知
    |       |-- user_controller.dart //用户管理
    |
    |-- middlewares // 路由中间件
    |   |-- routh_auth.dart // 鉴权
    |
    |-- model // 数据模型
    |   |-- parts
    |       |-- config.dart // 后台公共信息
    |       |-- contacts.dart // 联系人
    |       |-- notice.dart // 通知
    |       |-- package.dart // 会员套餐 
    |       |-- question.dart // 问题
    |       |-- trace.dart // 
    |       |-- user_info.dart
    |
    |-- router // 路由
    |
    |-- utils // 工具类
    |   |-- index.dart // 存储(storage)和 打印(logger)
    |   |-- parts
    |       |-- check_is_loading.dart // 检测是否是登录
    |       |-- check_is_vip.dart // 检测是否是vip
    |       |-- custom_dialog.dart // 公用dialog
    |       |-- lifecycle_wrapper.dart // 页面状态
    |       |-- request.dart // 获取数据
    |       |-- share.dart // 分享好友
    |
    |-- views
    |   |-- agreement // 协议页
    |   |-- contacts_add // 联系人添加页
    |   |-- contacts_setting // 联系人设置页
    |   |-- contacts_trace // 联系人轨迹列表页
    |   |-- contacts_trace_detail // 联系人轨迹详情页
    |   |-- index // 首页
    |   |   |-- pages
    |   |       |-- contacts // 联系人
    |   |       |-- emergency // 紧急求助
    |   |       |-- home // 首页
    |   |       |-- user // 用户
    |   |-- login // 登录页
    |   |-- login_code // 验证码登录页
    |   |-- notification // 通知页
    |   |-- password_forget // 忘记密码页
    |   |-- permission // 权限页
    |   |-- question // 问题列表页
    |   |-- question_detail // 问题详情页
    |   |-- reload
    |   |-- service // 客服页
    |   |-- setting // 设置页
    |   |-- vip_open // vip开通页
    |   |-- welcome // 欢迎页
    |
    |-- widget // 公用组件
        |-- cell // 单元格
        |-- contacts_list // 联系人列表
        |-- loading // 加载按钮
        |-- login_type // 登录状态(验证码 / 账号密码)
        |-- reload
        |-- vip_privilege // 会员权限
