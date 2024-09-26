import 'package:flutter_clean_with_bloc/features/auth/data/model/user_model.dart';

import '../../domain/entity/user_entity.dart' as entity;

class UserMapper {
  static entity.User userModelToEntity(UserModel userModel) {
    return entity.User(
      id: userModel.user?.id ?? 0,
      name: userModel.user?.name ?? '',
      firstName: userModel.user?.firstName ?? '',
      lastName: userModel.user?.lastName ?? '',
      phone: userModel.user?.phone ?? '',
      email: userModel.user?.email ?? '',
      username: userModel.user?.username ?? '',
      balance: userModel.user?.balance ?? '0',
      currencyBalance: userModel.user?.currencyBalance ?? '0',
      image: userModel.user?.image ?? '',
      roleId: userModel.user?.roleId ?? 0,
      countryCode: userModel.user?.countryCode ?? '',
      order: userModel.user?.order ?? 0,
      createDate: userModel.user?.createDate ?? '',
      updateDate: userModel.user?.updateDate ?? '',
    );
  }
}
