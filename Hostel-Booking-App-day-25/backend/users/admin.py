from django.contrib import admin

from .models import Hostel, BookedHostel, Room, SavedHostel, User

# Register your models here.
admin.site.register(User)
admin.site.register(Hostel)
admin.site.register(BookedHostel)
admin.site.register(Room)
admin.site.register(SavedHostel)