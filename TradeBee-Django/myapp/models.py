from django.contrib.auth.models import User
from django.db import models
from django.contrib.auth.models import AbstractUser
# Create your models here.


class Customer(models.Model):
    name = models.CharField(max_length=100)
    gender = models.CharField(max_length=100)
    dateofbirth =models.DateField()
    email = models.CharField(max_length=100)
    phone = models.CharField(max_length=10)
    place = models.CharField(max_length=100)
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    pincode = models.IntegerField()
    photo = models.CharField(max_length=400)
    status = models.CharField(max_length=50)
    AUTH_USER = models.OneToOneField(User,on_delete=models.CASCADE)


class News(models.Model):
    title = models.CharField(max_length=100)
    description = models.CharField(max_length=100)
    file = models.CharField(max_length=1000)
    date = models.DateField()


class Content(models.Model):
    video = models.CharField(max_length=400)
    title = models.CharField(max_length=100)
    date = models.DateField()
    type = models.CharField(max_length=200,default='')

class Notification(models.Model):
    notification = models.CharField(max_length=200)
    date = models.DateField()


class Complaint(models.Model):
    complaint = models.CharField(max_length=100)
    date = models.DateField()
    reply = models.CharField(max_length=100)
    status = models.CharField(max_length=100)
    CUSTOMER =models.ForeignKey(Customer,on_delete=models.CASCADE)

class Review(models.Model):
    rating = models.CharField(max_length=100)
    review = models.CharField(max_length=100)
    date = models.DateField()
    CUSTOMER = models.ForeignKey(Customer, on_delete=models.CASCADE)


class Video(models.Model):
    video = models.CharField(max_length=400)
    title = models.CharField(max_length=100)
    date = models.DateField()


class fav_stock(models.Model):
    name=models.CharField(max_length=100)
    CUSTOMER = models.ForeignKey(Customer, on_delete=models.CASCADE)

class Amount(models.Model):
    date=models.DateField()
    amount=models.FloatField()
    ststus=models.CharField(max_length=200)
    stock=models.CharField(max_length=200)
    CUSTOMER = models.ForeignKey(Customer, on_delete=models.CASCADE)

class Buy(models.Model):
    quantity=models.CharField(max_length=100)
    amount=models.CharField(max_length=200)
    name=models.CharField(max_length=200)
    date=models.DateField()
    currstockprice=models.FloatField(default=0)
    CUSTOMER = models.ForeignKey(Customer, on_delete=models.CASCADE)


class Sell(models.Model):
    stock=models.CharField(max_length=200)
    quantity =models.CharField(max_length=200)
    CUSTOMER = models.ForeignKey(Customer, on_delete=models.CASCADE)




