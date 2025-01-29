// data/mappers/user_mapper.dart
import '../../domain/entity/user_entity.dart';
import '../model/user_model.dart';

class UserMapper {
  // Convert UserModel to UserEntity
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.user?.id,
      name: model.user?.name,
      firstName: model.user?.firstName,
      lastName: model.user?.lastName,
      phone: model.user?.phone,
      email: model.user?.email,
      username: model.user?.username,
      balance: model.user?.balance,
      currencyBalance: model.user?.currencyBalance,
      image: model.user?.image,
      roleId: model.user?.roleId,
      countryCode: model.user?.countryCode,
      order: model.user?.order,
      createDate: model.user?.createDate,
      updateDate: model.user?.updateDate,
    );
  }
}