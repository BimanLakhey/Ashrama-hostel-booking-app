from django.contrib import admin
from django.urls import path, include
from users.views import *
from users import views
from backend import settings
from django.conf.urls.static import static
from rest_framework.routers import DefaultRouter

urlpatterns = [
    path('admin/', admin.site.urls),
    path('loginUser/', Login.as_view(), name="Login"),
    path('registerUser/', Register.as_view(), name="Register"),
    path('registerHostel/', RegisterHostel.as_view(), name="Register Hostel"),
    path('logoutUser/', Logout.as_view(), name="Logout"),
    path('updateUser/<int:pk>', UpdateProfile.as_view(), name="Profile"),
    path('updateHostel/<int:pk>', UpdateHostel.as_view(), name="Hostel Profile"),
    path('userProfile/<int:pk>', ViewUserProfile.as_view(), name="User Profile"),
    path('userDetails/', UserDetails.as_view(), name="User Details"),
    path('hostelDetails/', HostelsDetails.as_view(), name="Hostel Details"),
    path('hostelProfile/<int:pk>/', ViewHostelProfile.as_view(), name="Hostel profile"),
    # path('saveHostel/', SaveHostel.as_view(), name="Save hostel"),
    path('savedHostels/', SavedHostels.as_view(), name="Saved hostels"),
    # path('savedHostels/', SaveHostel.as_view(), name="Saved hostels"),
    # path('', include(router.urls))


] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
