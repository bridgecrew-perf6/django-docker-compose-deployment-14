from django.urls import path
from . import views

urlpatterns = [
	path('about-us/', views.AboutusView.as_view(), name='about_us'),
	path('', views.index_wrapper, name='home')
	,
]