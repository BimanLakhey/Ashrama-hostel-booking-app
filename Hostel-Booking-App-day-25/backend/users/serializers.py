from rest_framework import serializers
import datetime
from rest_framework.validators import UniqueValidator
from .models import *
from django.core.exceptions import ValidationError
from django.contrib.auth.hashers import make_password

baseURL = "http://192.168.0.200:8000";

class UserSerializer(serializers.ModelSerializer):
    
    username = serializers.CharField(required=True,validators=[UniqueValidator(queryset=User.objects.all())]) 
    userFName = serializers.CharField(required=True)
    userLName = serializers.CharField(required=True)
    userPassword = serializers.CharField(write_only=True,required=True,style={'input_type': 'password'})
    userEmail = serializers.EmailField(required=True,validators=[UniqueValidator(queryset=User.objects.all())])
    userCity = serializers.CharField(required=True)
    userStreet = serializers.CharField(required=True)
    userPhone = serializers.CharField(required=True)

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

    class Meta:
        model = User
        fields = ( 'id', 'username', 'userFName', 'userLName', 'userPassword', 'userEmail', 'userCity', 'userStreet', 'userPhone', 'userPhoto',)        
        extra_kwargs = {'userPassword': {'write_only': True}}

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
            data["userCity"] = user.userCity
            data["userStreet"] = user.userStreet
            data["userPhone"] = user.userPhone
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
            'userEmail', 
            'userCity',
            'userStreet',
            'userPhone', 
        )
        
    def update(self, instance, validated_data):
        instance.username = validated_data['username']
        instance.userFName = validated_data['userFName']
        instance.userLName = validated_data['userLName']
        # instance.userPassword = validated_data['userPassword']
        instance.userEmail = validated_data['userEmail']
        instance.userCity = validated_data['userCity']
        instance.userStreet = validated_data['userStreet']
        # instance.userPhoto = validated_data['userPhoto']
        instance.userPhone = validated_data['userPhone']
        instance.save()

        return instance

class ResetPasswordSerializer(serializers.ModelSerializer):
    userPassword = serializers.CharField(write_only=True,required=True,style={'input_type': 'password'})

    class Meta:
        model = User
        fields = (
            'userPassword', 
        )
        
    def update(self, instance, validated_data):
        instance.userPassword = validated_data['userPassword']
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
        )
    def update(self, instance, validated_data):
        instance.hostelName = validated_data['hostelName']
        instance.hostelCity = validated_data['hostelCity']
        instance.hostelStreet = validated_data['hostelStreet']
        instance.hostelType = validated_data['hostelType']
        instance.hostelPhone = validated_data['hostelPhone']
        instance.hostelTotalRooms = validated_data['hostelTotalRooms']
        instance.hostelPhoto = validated_data['hostelPhoto']
        instance.save()

class UpdateHostelSerializer(serializers.ModelSerializer):

    class Meta:
        model = Hostel
        fields = (
            'hostelName',
            'hostelCity',
            'hostelStreet',
            'hostelType',
            'hostelPhone',
            'hostelTotalRooms',
            # 'hostelPhoto',
        )
        
    def update(self, instance, validated_data):
        instance.hostelName = validated_data['hostelName']
        instance.hostelCity = validated_data['hostelCity']
        instance.hostelStreet = validated_data['hostelStreet']
        instance.hostelType = validated_data['hostelType']
        instance.hostelPhone = validated_data['hostelPhone']
        instance.hostelTotalRooms = validated_data['hostelTotalRooms']
        # instance.hostelPhoto = validated_data['hostelPhoto']
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
    checkingOutDate = serializers.DateField()
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
            'checkingOutDate',
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

class RegisteredHostelSerializer(serializers.ModelSerializer):
    
    userID = serializers.CharField()
    hostelID = serializers.CharField()
    
    class Meta:
        model = RegisteredHostel
        fields = [
            'id',
            'hostelID',
            'userID',
        ]

class UserReviewSerializer(serializers.ModelSerializer):
    
    userID = serializers.CharField()
    hostelID = serializers.CharField()
    rating = serializers.CharField()
    review = serializers.CharField()
    reviewDate = serializers.DateField()
    
    class Meta:
        model = UserReview
        fields = [
            'userID',
            'hostelID',
            'rating',
            'review',
            'reviewDate',
        ]

class UserNotificationSerializer(serializers.ModelSerializer):
    
    userID = serializers.CharField()
    hostelID = serializers.CharField()
    notificationMessage = serializers.CharField()
    notificationDate = serializers.DateTimeField(format="%d-%m-%Y %H:%M")

    class Meta:
        model = UserNotification
        fields = [
            'userID',
            'hostelID',
            'notificationMessage',
            'notificationDate',
        ]

class AmenitySerializer(serializers.ModelSerializer):
    amenityName = serializers.CharField()

    class Meta:
        model = Amenity
        fields = [
            'id',
            'amenityName',
        ]

class HostelAmenitySerializer(serializers.ModelSerializer):
    
    hostelID = serializers.CharField()
    amenityID = serializers.CharField()

    class Meta:
        model = HostelAmenity
        fields = [
            'id',
            'hostelID',
            'amenityID',
        ]


        
