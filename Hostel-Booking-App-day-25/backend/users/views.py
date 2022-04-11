from functools import partial
import http
from unicodedata import lookup
from django.shortcuts import redirect
from rest_framework import generics
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.status import *
from rest_framework import status, permissions
from .models import Hostel, SavedHostel, User
from .serializers import HostelSerializer, SavedHostelSerializer, UpdateHostelSerializer, UpdateUserSerializer, UserSerializer, UserLoginSerializer
from django.http import Http404

# Create your views here.


class CustomPermissionForUser(permissions.BasePermission):
    
    def __init__(self, allowed_methods):
        self.allowed_methods = allowed_methods

    def has_permission(self, request, view):
        if 'user_id' in request.session.keys():
            return request.method in self.allowed_methods

class Register(generics.ListCreateAPIView):
    # get method handler
    queryset = User.objects.all()
    serializer_class = UserSerializer


class Login(APIView):
    # get method handler
    serializer_class = UserLoginSerializer

    def post(self, request, format=None):
        serializer_class = UserLoginSerializer(data=request.data)
        if serializer_class.is_valid(raise_exception=True):
            request.session['user_id'] = serializer_class.validated_data["user_id"]
            return Response(
                {
                    #'UserDetails':serializer_class.data,
                    'user_id':serializer_class.validated_data['user_id'],
                    'username':serializer_class.validated_data['username'],
                    'userPassword':serializer_class.validated_data['userPassword'],
                    'userFName':serializer_class.validated_data['userFName'],
                    'userLName':serializer_class.validated_data['userLName'],
                    'userEmail':serializer_class.validated_data['userEmail'],
                    'userAddress':serializer_class.validated_data['userAddress'],
                    'userPhone':serializer_class.validated_data['userPhone'],
                    'userPhoto':serializer_class.validated_data['userPhoto'],
                },
                status=HTTP_200_OK
            )
        return Response(serializer_class.errors, status=HTTP_400_BAD_REQUEST)

class Logout(generics.GenericAPIView):
    def get(self, request, format=None):
        del request.session['user_id']
        data = {"logout": "logged out successfully"}
        return Response(data, status=HTTP_200_OK)

class ViewUserProfile(APIView):
    def get_user(self, pk):
        try:
            return User.objects.get(pk=pk)
        except:
            raise HTTP_400_BAD_REQUEST
    def get(self, request, pk, format=None):
        user = self.get_user(pk)
        serializer = UserSerializer(user)
        return Response(serializer.data)

class ViewHostelProfile(APIView):
    def get_hostel(self, pk):
        try:
            return Hostel.objects.get(pk=pk)
        except:
            raise HTTP_400_BAD_REQUEST
    def get(self, request, pk, format=None):
        hostel = self.get_hostel(pk)
        serializer = HostelSerializer(hostel)
        return Response(serializer.data)

class UpdateProfile(generics.UpdateAPIView):
    queryset = User.objects.all()
    serializer_class = UpdateUserSerializer

class UserDetails(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class RegisterHostel(generics.ListCreateAPIView):
    queryset = Hostel.objects.all()
    serializer_class = HostelSerializer

class HostelsDetails(generics.ListAPIView):
    queryset = Hostel.objects.all()
    serializer_class = HostelSerializer

class UpdateHostel(generics.UpdateAPIView):
    queryset = Hostel.objects.all()
    serializer_class = UpdateHostelSerializer


class SavedHostels(generics.ListCreateAPIView):
    queryset = SavedHostel.objects.all()
    # hostel = Hostel.objects.get(id=hostel_id);
    serializer_class = SavedHostelSerializer
    # permission_classes = (partial(CustomPermissionForUser, ['GET', 'HEAD', 'POST']))


    def get_object(self, pk):
        try:
            return SavedHostel.objects.get(pk=pk)
        except SavedHostel.DoesNotExist:
            raise Http404
        
    def delete(self, request, pk, format=None):
        savedHostel = self.get_object(pk)
        savedHostel.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    filter_fields = (
        'userID',
    )
