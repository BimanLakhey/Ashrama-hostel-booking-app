from django.contrib import admin

from .models import BookedHostel, Hostel, SavedHostel, User

# Register your models here.
admin.site.register(User)
admin.site.register(Hostel)
admin.site.register(BookedHostel)
admin.site.register(SavedHostel)