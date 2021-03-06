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
    totalHostels = models.CharField(max_length=100, null=True)
    ownerLicense = models.CharField(max_length=50, null=True)

    def __str__(self):
        return f"{self.username}" + " - " + f"{self.id}"

class Hostel(models.Model):
    hostelName = models.CharField(max_length=50, unique=True, null=False)
    hostelCity = models.CharField(max_length=50, null=False)
    hostelStreet = models.CharField(max_length=50, null=False)
    hostelType = models.CharField(max_length=50, null=False)
    hostelPhone = models.CharField(max_length=50, null=False, default='00000000')
    hostelTotalRooms = models.CharField(max_length=100, null=False)
    hostelPhoto = models.ImageField(upload_to='', null= True)
    hostelOwnerID = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.hostelName}" + " - " + f"{self.id}"

class BookedHostel(models.Model):
    hostelID = models.ForeignKey(Hostel, on_delete=models.CASCADE)
    userID = models.ForeignKey(User, on_delete=models.CASCADE)
    bookingDate = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.id}"

class SavedHostel(models.Model):
    hostelID = models.ForeignKey(Hostel, related_name='hostels', on_delete=models.CASCADE)
    userID = models.ForeignKey(User, related_name='users', on_delete=models.CASCADE)
 
    def __str__(self):
        return f"{self.userID}"
