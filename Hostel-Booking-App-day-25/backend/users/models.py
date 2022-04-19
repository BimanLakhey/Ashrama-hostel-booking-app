from email.policy import default
from tkinter import CASCADE
from django.db import models

# Create your models here.
class User(models.Model):
    username = models.CharField(max_length=50, unique=True, null=False)
    userFName = models.CharField(max_length=50, null=False)
    userLName = models.CharField(max_length=50, null=False)
    userPassword = models.CharField(max_length=50, null=False)
    userEmail = models.CharField(max_length=50, null=False)
    userAddress = models.CharField(max_length=100, null=False)
    userPhone = models.CharField(max_length=100, null=False)
    userPhoto = models.ImageField(upload_to='', null= True, default='defaultProfie.jpg')

    def __str__(self):
        return f"{self.id}"

class Hostel(models.Model):
    hostelName = models.CharField(max_length=50, unique=True, null=False)
    hostelCity = models.CharField(max_length=50, null=False)
    hostelStreet = models.CharField(max_length=50, null=False)
    hostelType = models.CharField(max_length=50, null=False)
    hostelPhone = models.CharField(max_length=50, null=False, default='00000000')
    hostelTotalRooms = models.CharField(max_length=100, null=False)
    hostelPhoto = models.ImageField(upload_to='', null= True, default='defaultHostel.jpg')

    def __str__(self):
        return f"{self.id}"

class Room(models.Model):
    roomType = models.CharField(max_length=50, unique=True, null=False)
    roomPrice = models.CharField(max_length=50, null=False)
    
    def __str__(self):
        return f"{self.id}"

class BookedHostel(models.Model):
    hostelID = models.CharField(max_length=50)
    userID = models.CharField(max_length=50)
    bookingDate = models.DateField()
    checkingOutDate = models.DateField()
    roomID = models.CharField(max_length=50)
    roomType = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.id}"

class SavedHostel(models.Model):
    hostelID = models.CharField(max_length=50)
    userID = models.CharField(max_length=50)
 
    def __str__(self):
        return f"{self.id}"

class RegisteredHostel(models.Model):
    hostelID = models.CharField(max_length=50)
    userID = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.id}"

class UserReview(models.Model):
    userID = models.CharField(max_length=50)
    hostelID = models.CharField(max_length=50)
    rating = models.CharField(max_length=50)
    review = models.CharField(max_length=200)
    reviewDate = models.DateField()
    