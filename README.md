# https://zhuanlan.zhihu.com/p/395810338
http://www.blackharry.com/2019/04/07/Flutter的Bloc工程化系列1/

# 启动
flutter run -d macos

# 创建package
flutter create --template=package packages/authentication_repository
flutter create --template=package packages/user_repository


# 历史
## 创建dio_demo
flutter create dio_demo --org net.aoisoft

### 添加DIO依赖 当前版本5.4.0
flutter pub add dio