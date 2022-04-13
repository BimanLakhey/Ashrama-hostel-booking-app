from rest_framework import serializers
import datetime
from rest_framework.validators import UniqueValidator
from .models import BookedHostel, Hostel, Room, SavedHostel, User
from django.core.exceptions import ValidationError

baseURL = "http://100.64.242.219:8000";

class UserSerializer(serializers.ModelSerializer):
    
    username = serializers.CharField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all())]
        ) 
    userFName = serializers.CharField( 
        required=True)
    userLName = serializers.CharField(
        required=True)
    userPassword = serializers.CharField(max_length=50)
    userEmail = serializers.EmailField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all())]
        )
    userAddress = serializers.CharField(
        required=True)
    userPhone = serializers.CharField(
        required=True)
    totalHostels = serializers.CharField(
        required=True)
    ownerLicense = serializers.CharField(max_length=50)

    class Meta:
        model = User
        fields = (
            'username',
            'userFName',
            'userLName',
            'userPassword',
            'userEmail',
            'userAddress',
            'userPhone',
            'totalHostels',
            'ownerLicense',
        )        

class UserLoginSerializer(serializers.ModelSerializer):
    # to accept either username or email
    username = serializers.CharField()
    userPassword = serializers.CharField()
    class Meta:
        model = User
        fields = (
            'username',
            'userPassword',
        )
    def validate(self, data):
        
        username = data.get("username")
        userPassword = data.get("userPassword")

        if not username and userPassword:
            raise ValidationError("Username and Password is required")
        try:
            user = User.objects.get(username=username)
        except User.DoesNotExist:
            raise ValidationError("This username does not exist")
        if user.userPassword == userPassword:
            data["user_id"] = user.id
            data["userFName"] = user.userFName
            data["userLName"] = user.userLName
            data["userEmail"] = user.userEmail
            data["userAddress"] = user.userAddress
            data["userPhone"] = user.userPhone
            # image_data = base64.b64encode(user.userPhoto.read()).decode('utf-8')
            data["userPhoto"] =baseURL + user.userPhoto.url
            return data;
        else:
            raise ValidationError("Invalid credentials")


class UpdateUserSerializer(serializers.ModelSerializer):
    username = serializers.CharField(required=True)

    class Meta:
        model = User
        fields = (
            'username', 
            'userFName', 
            'userLName', 
            'userPassword', 
            'userEmail', 
            'userAddress',
            'userPhoto', 
            'userPhone', 
        )
        

    def validate_email(self, value):
        user = self.context['request'].user
        if User.objects.exclude(pk=user.pk).filter(userEmail=value).exists():
            raise serializers.ValidationError({"userEmail": "This email is already in use."})
        return value

    def validate_username(self, value):
        user = self.context['request'].user
        if User.objects.exclude(pk=user.pk).filter(username=value).exists():
            raise serializers.ValidationError({"username": "This username is already in use."})
        return value

    def update(self, instance, validated_data):
        instance.username = validated_data['username']
        instance.userFName = validated_data['userFName']
        instance.userLName = validated_data['userLName']
        instance.userPassword = validated_data['userPassword']
        instance.userEmail = validated_data['userEmail']
        instance.userAddress = validated_data['userAddress']
        instance.userPhoto = validated_data['userPhoto']
        instance.userPhone = validated_data['userPhone']
        instance.save()

        return instance

class HostelSerializer(serializers.ModelSerializer):

    class Meta:
        model = Hostel
        fields = (
            'id',
            'hostelName',
            'hostelCity',
            'hostelStreet',
            'hostelType',
            'hostelPhone',
            'hostelTotalRooms',
            'hostelPhoto',
            'hostelOwnerID',
        )
    def update(self, instance, validated_data):
        instance.hostelName = validated_data['hostelName']
        instance.hostelCity = validated_data['hostelCity']
        instance.hostelStreet = validated_data['hostelStreet']
        instance.hostelType = validated_data['hostelType']
        instance.hostelPhone = validated_data['hostelPhone']
        instance.hostelTotalRooms = validated_data['hostelTotalRooms']
        instance.hostelPhoto = validated_data['hostelPhoto']
        instance.hostelOwnerID = validated_data['hostelOwnerID']
        instance.save()

class UpdateHostelSerializer(serializers.ModelSerializer):
    hostelName = serializers.CharField(required=True)

    class Meta:
        model = Hostel
        fields = (
            'hostelName',
            'hostelCity',
            'hostelStreet',
            'hostelType',
            'hostelPhone',
            'hostelTotalRooms',
            'hostelPhoto',
            'hostelOwnerID',
        )
        
    def update(self, instance, validated_data):
        instance.hostelName = validated_data['hostelName']
        instance.hostelCity = validated_data['hostelCity']
        instance.hostelStreet = validated_data['hostelStreet']
        instance.hostelType = validated_data['hostelType']
        instance.hostelPhone = validated_data['hostelPhone']
        instance.hostelTotalRooms = validated_data['hostelTotalRooms']
        instance.hostelPhoto = validated_data['hostelPhoto']
        instance.hostelOwnerID = validated_data['hostelOwnerID']
        instance.save()

        return instance

class RoomSerializer(serializers.ModelSerializer):
    
    roomType = serializers.CharField(
        required=True,
        validators=[UniqueValidator(queryset=Room.objects.all())]
        ) 
    roomPrice = serializers.CharField( 
        required=True)

    class Meta:
        model = Room
        fields = (
            'id',
            'roomType',
            'roomPrice',
        )        

class BookedHostelSerializer(serializers.ModelSerializer):
    
    userID = serializers.CharField()
    hostelID = serializers.CharField()
    bookingDate = serializers.DateField()
    roomType = serializers.CharField()
    roomID = serializers.CharField()
    
    class Meta:
        model = BookedHostel
        fields = [
            'id',
            'hostelID',
            'userID',
            'roomType',
            'bookingDate',
            'roomID',
        ]
        
class SavedHostelSerializer(serializers.ModelSerializer):

    userID = serializers.CharField()
    hostelID = serializers.CharField()
    
    class Meta:
        model = SavedHostel
        fields = [
            'id',
            'hostelID',
            'userID',
        ]
        
