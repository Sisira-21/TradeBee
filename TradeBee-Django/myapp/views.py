import datetime
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import Group
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

# Create your views here.
from django.views.decorators.csrf import csrf_exempt

from myapp.models import *


from django.contrib.auth.models import User

# user = User.objects.get(username='admin@gmail.com')  # or use id, email, etc.
#
# # Set new password
# user.set_password('Admin')
# user.save()


def login_get(req):
    return render(req,'loginindex1.html')

def login_post(req):
    if req.method == "POST":
        username = req.POST['username']
        password = req.POST['password']

        user=authenticate(req,username=username,password=password)
        if user is not None:
            if user.groups.filter(name='admins'):
                login(req,user)
                return redirect('/myapp/adminhome_get/')
            else:
                messages.warning(req,'user does not exist')
                return redirect('/myapp/login_get/')

        else:
            messages.warning(req,'invalid username or password')
            return redirect('/myapp/login_get/')
    return render(req,'loginindex1.html')

def logout1(req):
    logout(req)
    return redirect('/myapp/login_get/')


def adminhome_get(req):
    return render(req,'Adminpages/aindex.html')

def adminview_user(req):
    data = Customer.objects.filter(status='pending')
    return render(req,'Adminpages/viewuser.html',{'customer':data})

def adminblocked_user(req):
    data = Customer.objects.filter(status='blocked')
    return render(req, 'Adminpages/view blockeduser.html', {'customer': data})

def block_user(req,id):
    Customer.objects.filter(id=id).update(status='blocked')
    messages.success(req,"Blocked Successfully")
    return redirect('/myapp/adminblocked_user/#a')


def unblock_users(req,id):
    Customer.objects.filter(id=id).update(status='pending')
    messages.success(req, "Unblocked Successfully")
    return redirect('/myapp/adminview_user/#a')



def adminadd_content_get(req):
    return render(req,'Adminpages/add content.html')

def adminadd_content_post(req):
    type= req.POST['type']
    title = req.POST['title']
    video = req.FILES['video']
    if type == "video":
        fs=FileSystemStorage()
        date=datetime.datetime.now().strftime("%Y%m%d%H%M%S")+".mp4"
        fs.save(date,video)
        path=fs.url(date)

        c = Content()
        c.video = path
        c.title = title
        c.type = type
        c.date = datetime.datetime.now().today()
        c.save()
        messages.success(req,'Added Successfully')
        return redirect('/myapp/adminview_content/#a')
    else:
        fs = FileSystemStorage()
        date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".pdf"
        fs.save(date, video)
        path = fs.url(date)


        c = Content()
        c.video = path
        c.title = title
        c.type = type
        c.date = datetime.datetime.now().today()
        c.save()
        messages.success(req, 'Added Successfully')
        return redirect('/myapp/adminview_content/#a')

def adminview_content(req):
    c = Content.objects.all()
    return render(req, 'Adminpages/view content.html', {'data': c})

def edit_content_get(req,id):
    c = Content.objects.get(id=id)
    return render(req,'Adminpages/edit content.html',{'data': c})
def edit_content_post(req):
    id = req.POST['id']
    type = req.POST['type']
    title = req.POST['title']

    if 'video' in req.FILES:
        video = req.FILES['video']
        if  type=='article':

            fs = FileSystemStorage()
            date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".pdf"
            fs.save(date, video)
            path = fs.url(date)

            c = Content.objects.get(id=id)
            c.video = path
            c.title = title
            c.type = type
            c.date = datetime.datetime.now().today()
            c.save()

            messages.success(req, 'Edit Successfully')
            return redirect('/myapp/adminview_content/')
        else:
            fs = FileSystemStorage()
            date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".mp4"
            fs.save(date, video)
            path = fs.url(date)

            c = Content.objects.get(id=id)
            c.video = path
            c.title = title
            c.type = type
            c.date = datetime.datetime.now().today()
            c.save()

            messages.success(req, 'Edit Successfully')
            return redirect('/myapp/adminview_content/')
    else:
        c = Content.objects.get(id=id)
        c.title = title
        c.type = type
        c.date = datetime.datetime.now().today()
        c.save()
        messages.success(req, 'Edit Successfully')
        return redirect('/myapp/adminview_content/')


def delete_content(req,id):
    Content.objects.get(id=id).delete()
    messages.success(req, 'Delete Successfully')
    return redirect('/myapp/adminview_content/#a')

def search_content(req):
    fdate = req.POST['fdate']
    tdate = req.POST['tdate']
    data = Content.objects.filter(date__range=[fdate,tdate])
    return render(req,'Adminpages/view content.html',{'data':data})




def adminadd_video_get(req):
    return render(req,'Adminpages/add video.html')
#
# def adminadd_video_post(req):
#
#     title = req.POST['title']
#     video = req.FILES['video']
#
#
#     fs=FileSystemStorage()
#     date=datetime.datetime.now().strftime("%Y%m%d%H%M%S")+".mp4"
#     fs.save(date,video)
#     path=fs.url(date)
#
#     a = Video()
#     a.video = path
#     a.title = title
#     a.date = datetime.datetime.now()
#     a.save()
#     messages.success(req, 'Added Successfully')
#     return redirect('/myapp/adminview_video/#a')



def adminadd_video_post(req):

    title = req.POST.get('title')
    video = req.FILES.get('video')


    fs = FileSystemStorage()
    filename = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".mp4"
    fs.save(filename, video)
    path = fs.url(filename)


    if not video:
        messages.error(req, "No video selected")
        return redirect('/myapp/adminview_video/#a')


    if not video.name.endswith('.mp4'):
        messages.error(req, "Only MP4 videos are allowed")
        return redirect('/myapp/adminview_video/#a')


    if video.size > 50 * 1024 * 1024:
        messages.error(req, "File size must be less than 50MB")
        return redirect('/myapp/adminview_video/#a')
    #
    # fs = FileSystemStorage()
    # filename = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".mp4"
    # fs.save(filename, video)
    # path = fs.url(filename)


    a = Video()
    a.video = path
    a.title = title
    a.date = datetime.datetime.now()
    a.save()

    messages.success(req, 'Video added successfully')
    return redirect('/myapp/adminview_video/#a')

def adminview_video(req):

    b=Video.objects.all()
    return render(req,'Adminpages/view video.html',{'data':b})

def search_video(req):
    fdate = req.POST['fdate']
    tdate = req.POST['tdate']
    data = Video.objects.filter(date__range=[fdate,tdate])
    return render(req,'Adminpages/view video.html',{'data':data})



def adminedit_video_get(req,id):
    a = Video.objects.get(id=id)
    return render(req,'Adminpages/edit video.html',{'data':a})
def adminedit_video_post(req):
    id = req.POST['id']
    title = req.POST['title']
    video = req.FILES['video']
    if 'video' in req.FILES:
        video = req.FILES['video']
        fs = FileSystemStorage()
        date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".mp4"
        fs.save(date, video)
        path = fs.url(date)

        a = Video.objects.get(id=id)
        a.video = path
        a.title = title
        a.date = datetime.datetime.now()
        a.save()
        messages.success(req, 'Edit Successfully')
        return redirect('/myapp/adminview_video/')
    else:
        a = Video.objects.get(id=id)
        a.title = title
        a.date = datetime.datetime.now()
        a.save()
        messages.success(req, 'Edit Successfully')
        return redirect('/myapp/adminview_video/')

def admindelete_video(req,id):
    Video.objects.get(id=id).delete()
    messages.success(req,'Delete Successfully')
    return redirect('/myapp/adminview_video/#a')


def adminnews_add_get(req):
    return render(req,'Adminpages/add news.html')

def adminews_add_post(req):
    title = req.POST['title']
    description= req.POST['description']
    file= req.FILES["file"]

    fs = FileSystemStorage()
    date = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ".jpg"
    fs.save(date, file)
    path = fs.url(date)


    # date = req.POST['']
    # date= datetime.now()

    a = News()
    a.title = title
    a.description = description
    a.date=datetime.datetime.now()
    a.file=path
    a.save()
    messages.success(req,'Added Successfully')
    return redirect('/myapp/adminnews_add_get/')


def adminview_news(req):
    a = News.objects.all()
    return render(req,'Adminpages/view news.html',{'data':a})

def search_news(req):
    fdate = req.POST['fdate']
    tdate = req.POST['tdate']
    data = News.objects.filter(date__range=[fdate,tdate])
    return render(req,'Adminpages/view news.html',{'data':data})



def adminedit_news_get(req,id):
    a = News.objects.get(id=id)
    return render(req,'Adminpages/Edit News.html',{'data':a})

def adminedit_news_post(req):
    id = req.POST['id']
    title = req.POST['title']
    description = req.POST['description']
    # date = req.POST['']

    a = News.objects.get(id=id)
    a.title = title
    a.description = description
    a.date = datetime.datetime.now()
    a.save()
    messages.success(req,'Added Successfully')
    return redirect('/myapp/adminview_news/')

def admindelete_news(req,id):
    News.objects.get(id=id).delete()
    return redirect('/myapp/adminview_news/')


def asend_notification_get(req):
    return render(req,'Adminpages/Add Notification.html')

def asend_notification_post(req):
    notification= req.POST['notification']

    noti=Notification()
    noti.notification=notification
    noti.date=datetime.datetime.now()
    noti.save()

    return redirect('/myapp/asend_notification_get/')

def asendview_notification(req):
    da=Notification.objects.all()

    return render(req,'Adminpages/view notification.html',{'data':da})

def search_noti(req):
    fdate = req.POST['fdate']
    tdate = req.POST['tdate']
    data = Notification.objects.filter(date__range=[fdate,tdate])
    return render(req,'Adminpages/view notification.html',{'data':data})

def adminedit_noti_get(req,id):
    noti = Notification.objects.get(id=id)
    return render(req,'Adminpages/Edit Notification.html',{'data':noti})

def adminedit_noti_post(req):
    id = req.POST['id']
    notification = req.POST['notification']

    noti = Notification.objects.get(id=id)
    noti.notification = notification
    noti.date = datetime.datetime.now()
    noti.save()
    return redirect('/myapp/asendview_notification/')

def admindelete_noti(req,id):
    Notification.objects.get(id=id).delete()
    return redirect('/myapp/asendview_notification/')


def admin_feedback(req):
    a = Review.objects.all()
    return render(req,'Adminpages/view feedback.html',{'data':a})

def search_feedback(req):
    fdate = req.POST['fdate']
    tdate = req.POST['tdate']
    data = Review.objects.filter(date__range=[fdate,tdate])
    return render(req,'Adminpages/view feedback.html',{'data':data})



def admin_complaint(req):
    b = Complaint.objects.all()
    return render(req,'Adminpages/viewcomplaint.html',{'data':b})

def search_comp(req):
    fdate = req.POST['fdate']
    tdate = req.POST['tdate']
    data = Notification.objects.filter(date__range=[fdate,tdate])
    return render(req,'Adminpages/viewcomplaint.html',{'data':data})



def reply_get(req,id):
    return render(req,'Adminpages/Send Reply.html',{'id':id})

def reply_post(req):
    reply= req.POST['reply']
    id = req.POST['id']

    data = Complaint.objects.get(id=id)
    data.reply=reply
    data.status='Replied'
    data.save()
    return redirect('/myapp/admin_complaint/')


def achangepassword(req):
    return render(req,'Adminpages/changepass.html')

def changep_post(req):
    currentp=req.POST['currentp']
    newp=req.POST['newp']
    conp=req.POST['conp']
    data=req.user
    if not data.check_password(currentp):
        messages.error(req,'invalid password')
        return render(req, 'Adminpages/changepass.html')
    if newp!=conp:
        messages.error(req, 'password do not match')
        return render(req, 'Adminpages/changepass.html')
    data.set_password(newp)
    data.save()
    return redirect('/myapp/login_get/')

def admin_report(req):
    return render()



######################################################Android

@csrf_exempt
def user_login_post(req):
    username = req.POST['uUsername']
    password = req.POST['upassword']

    print(username,password,"ggggggggggggggggggggg")

    user=authenticate(req,username=username,password=password)
    if user is not None:
        if user.groups.filter(name='customer'):
            if Customer.objects.filter(status = 'pending',AUTH_USER=user).exists():
                login(req,user)
                return JsonResponse({'status':'ok','lid':str(user.id)})
            else:
                return JsonResponse({'status':'blocked'})
        else:
            return JsonResponse({'status':'No'})
    else:
        return JsonResponse({'status':'No'})

@csrf_exempt
def user_changep_post(req):
    currentp=req.POST['currentp']
    newp=req.POST['newp']
    conp=req.POST['conp']
    lid=req.POST['lid']
    data=User.objects.get(id=lid)
    if not data.check_password(currentp):
        return JsonResponse({'status': 'No'})
    if newp!=conp:
        messages.error(req, 'password do not match')
        return JsonResponse({'status': 'No'})
    data.set_password(newp)
    data.save()
    return JsonResponse({'status': 'ok'})


@csrf_exempt
def user_viewsignup(req):
    name=req.POST['uname']
    print(name)
    gender=req.POST['gender']
    dateofbirth=req.POST['udateofbirth']
    email=req.POST['email']
    phone=req.POST['phone']
    place=req.POST['place']
    city=req.POST['city']
    state=req.POST['state']
    pincode=req.POST['pincode']
    photo=req.FILES['photo']

    fs=FileSystemStorage()
    date=datetime.datetime.now().strftime("%Y%m%d%H%M%S")+".jpg"
    fs.save(date,photo)
    path=fs.url(date)
    password=req.POST['password']
    confirmpassword=req.POST['confirmpassword']



    if User.objects.filter(username=email).exists():
        return JsonResponse({'status':'invalid'})

    if password==confirmpassword:
        user=User.objects.create_user(username=email,password=password)
        user.groups.add(Group.objects.get(name='customer'))
        user.save()

        a=Customer()
        a.name=name
        a.gender=gender
        a.dateofbirth=dateofbirth
        a.email=email
        a.phone=phone
        a.place=place
        a.city=city
        a.state=state
        a.pincode=pincode
        a.AUTH_USER=user
        a.photo=path
        a.status='pending'
        a.save()


        return JsonResponse({'status': 'ok'})

    return JsonResponse({'status': 'invalid'})

@csrf_exempt
def user_viewprofile(req):
    lid=req.POST['lid']
    print(lid,'88888888888888888888888888')
    a=Customer.objects.get(AUTH_USER_id=lid)
    return JsonResponse({'status': 'ok',
                         'name':a.name,
                         'gender': a.gender,
                        'dateofbirth': a.dateofbirth,
                         'email':a.email,
                         'phone':a.phone,
                         'place':a.place,
                         'city':a.city,
                         'state':a.state,
                         'pincode': a.pincode,
                         'photo':a.photo


                         })
@csrf_exempt
def user_viewnoti(req):
    a=Notification.objects.all()
    data=[]
    for i in a:
        data.append(
            {
                'id':i.id,
                'notification':i.notification,
                'date':i.date
            }

        )

    return JsonResponse({'status': 'ok','data':data})


@csrf_exempt
def user_viewvideo(req):
    a=Video.objects.all()
    data=[]
    for i in a:
        data.append(
            {
                'id':i.id,
                'video':i.video,
                'title':i.title,
                'date': i.date
            }
        )
    print(data,"hhhhhhhhhh")
    return JsonResponse({'status': 'ok','data':data})

@csrf_exempt
def user_viewcontent(req):
    a=Content.objects.all()
    data=[]
    for i in a:
        data.append(
            {
               'id': i.id,
                'video':i.video,
                'title':i.title,
                'type':i.type,
                'date':i.date
            }
        )
    return JsonResponse({'status': 'ok','data':data})


@csrf_exempt
def user_viewreply(req):
    lid=req.POST['lid']
    a = Complaint.objects.filter(CUSTOMER__AUTH_USER_id=lid)
    data = []
    for i in a:
        data.append(
            {
                'id':i.id,
               'complaint': i.complaint,
                'status':i.status,
                 'date':i.date,
                 'reply':i.reply

            }
        )
    return JsonResponse({'status': 'ok','data':data})

@csrf_exempt
def user_viewnews(req):
    a = News.objects.all()
    data = []
    for i in a:
        data.append(
            {
                'id': i.id,
                'title':i.title,
                'description':i.description,
                'date':i.date


            }
        )
    return JsonResponse({'status': 'ok', 'data': data})



@csrf_exempt
def user_editprofile(req):
    name = req.POST['name']
    gender = req.POST['gender']
    dateofbirth = req.POST['dateofbirth']
    email = req.POST['email']
    phone = req.POST['phone']
    place = req.POST['place']
    city = req.POST['city']
    state = req.POST['state']
    pincode = req.POST['pincode']

    lid = req.POST['lid']
    a = Customer.objects.get(AUTH_USER=lid)

    d=User.objects.get(id=lid)
    d.username=email
    d.save()

    if 'photo' in req.FILES:
        photo = req.FILES['photo']
        fs=FileSystemStorage()
        date=datetime.datetime.now().strftime("%Y%m%d%H%M%S")+".jpg"
        fs.save(date,photo)
        path=fs.url(date)
        a.photo = path
        a.save()
    a.name = name
    a.gender = gender
    a.dateofbirth = dateofbirth
    a.email = email
    a.phone = phone
    a.place = place
    a.city = city
    a.state = state
    a.pincode = pincode

    a.save()


    return JsonResponse({'status': 'ok'})


@csrf_exempt
def user_sendcomplanit(req):
    complaint=req.POST['complaint']
    lid=req.POST['lid']


    b=Complaint()
    b.complaint=complaint
    b.date=datetime.datetime.now().today()
    b.reply='pending'
    b.status='pending'
    b.CUSTOMER=Customer.objects.get(AUTH_USER=lid)
    b.save()

    return JsonResponse({'status': 'ok'})

@csrf_exempt
def user_sendreview(req):
    rating=req.POST['rating']
    review=req.POST['review']
    lid=req.POST['lid']

    a=Review()
    a.rating=rating
    a.review=review
    a.date=datetime.datetime.now().today()
    a.CUSTOMER = Customer.objects.get(AUTH_USER=lid)
    a.save()

    return JsonResponse({'status': 'ok'})

@csrf_exempt
def stock_detail(request):

    name=request.POST["name"]
    import yfinance as yd

    cdate= datetime.datetime.now().strftime("%Y-%m-%d")
    # Fetch stock data for one stock (e.g., AAPL for Apple)
    stock_data = yd.download(name, start='2022-01-01', end=cdate, interval='1d')

    d=stock_data
    print(d.values,"dddddddddddd")
    l=[]

    for i in d.values:

        print(i)

        l.append(
            {
                'date':i[0],
                'open':i[1],
                'high':i[2],
                'low':i[3],
                'close':i[4],
                'volume':i[4],

              }
        )
        # print(i[0],"dateeeeeeeeeeeeeee")

    return JsonResponse({'status':'ok','data': l})

@csrf_exempt
def getallstock(request):
    # lid=request.POST["lid"]
    import pandas as pd
    # Fetch most traded stocks from Yahoo Finance

    import pandas as pd
    import requests
    url_link = 'https://finance.yahoo.com/markets/stocks/most-active/'
    r = requests.get(url_link, headers={
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'})

    print(r.text)

    most_traded_stocks = pd.read_html(r.text)



    ############################


    # most_traded_stocks = pd.read_html('https://finance.yahoo.com/markets/stocks/most-active/')
    # most_traded_stocks = pd.read_html('https://finance.yahoo.com/markets/stocks/trending/')
    # most_traded_stocks = pd.read_html('https://finance.yahoo.com/most-active')
    most_traded_stocks = most_traded_stocks[0]  # Assuming the table is the first one on the page

    # Extract stock symbols
    stock_symbols = most_traded_stocks['Symbol'].tolist()
    p = most_traded_stocks['Price'].tolist()


    # Print the list of stock symbols
    print(stock_symbols)

    s=[]
    m=0

    for i in stock_symbols:
        print(i, type(i))

        if isinstance(i,str):
            pass
        else:
            continue

        pr=p[m].split(' ')[0]
        m=m+1





        s.append({'name':i,'price':pr})

    print(s,"======")

    return JsonResponse({'data':s,'status':'ok'})

@csrf_exempt
def add_fav(req):
    lid=req.POST['lid']
    name=req.POST['name']
    amount=req.POST['price']
    from datetime import datetime
    if fav_stock.objects.filter(CUSTOMER__AUTH_USER=lid,name=name).exists():
        fav_stock.objects.filter(name=name,CUSTOMER__AUTH_USER=lid).delete()
    else:
        f=fav_stock()
        f.CUSTOMER=Customer.objects.get(AUTH_USER=lid)
        f.name=name
        f.save()



        a=Amount()
        a.date=datetime.now().today()
        a.amount=amount
        a.ststus='pending'
        a.stock=name
        a.CUSTOMER = Customer.objects.get(AUTH_USER=lid)
        a.save()


    return JsonResponse({'status':'ok'})



# @csrf_exempt
# def add_fav(req):
#     from datetime import datetime
#
#     lid = req.POST.get('lid')
#     name = req.POST.get('name')
#     amount = req.POST.get('price')
#
#     try:
#         customer = Customer.objects.get(AUTH_USER=lid)
#     except Customer.DoesNotExist:
#         return JsonResponse({'status': 'invalid_user'})
#
#     fav, created = fav_stock.objects.get_or_create(
#         CUSTOMER=customer,
#         name=name
#     )
#
#     if not created:
#         # Already exists → remove (toggle behavior)
#         fav.delete()
#         return JsonResponse({'status': 'removed'})
#
#     # If newly created, save amount
#     Amount.objects.create(
#         date=datetime.now(),
#         amount=amount,
#         status='pending',
#         stock=name,
#         CUSTOMER=customer
#     )
#
#     return JsonResponse({'status': 'added'})


@csrf_exempt
def view_favstock(req):
    lid = req.POST['lid']
    data = fav_stock.objects.filter(CUSTOMER__AUTH_USER=lid)
    l=[]
    for i in data:
        l.append({
            'name':i.name,
            'id':i.id

        })
    return JsonResponse({'status':'ok','data':l})

@csrf_exempt
# def view_price(req):
#     lid = req.POST['lid']
#     name=req.POST['name']
#     print(lid,name)
#     data=Amount.objects.get(stock=name,CUSTOMER__AUTH_USER=lid)
#     # if data
#     return JsonResponse({'status':'ok','date':data.date,'amount':data.amount,'stock':data.stock})

def view_price(req):
    lid = req.POST.get('lid')
    name = req.POST.get('name')
    print(lid, name)

    # Use filter().first() to avoid DoesNotExist
    data = Amount.objects.get(stock=name, CUSTOMER__AUTH_USER=lid)

    if data:
        print(data,"============")
        return JsonResponse({'status': 'ok', 'date': data.date, 'amount': data.amount, 'stock': data.stock})
    else:
        # No record found
        return JsonResponse({'status': 'error', 'message': 'No amount found for this stock'})

# def view_favstock(request):
#     lid = request.POST['lid']
#     data = fav_stock.objects.filter(CUSTOMER__AUTH_USER=lid)
#
#     import pandas as pd
#     # Fetch most traded stocks from Yahoo Finance
#
#     import pandas as pd
#     import requests
#     url_link = 'https://finance.yahoo.com/markets/stocks/most-active/'
#     r = requests.get(url_link, headers={
#         'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'})
#
#     print(r.text)
#
#     most_traded_stocks = pd.read_html(r.text)
#
#     ############################
#
#
#
#     # most_traded_stocks = pd.read_html('https://finance.yahoo.com/markets/stocks/most-active/')
#     # most_traded_stocks = pd.read_html('https://finance.yahoo.com/markets/stocks/trending/')
#     # most_traded_stocks = pd.read_html('https://finance.yahoo.com/most-active')
#     most_traded_stocks = most_traded_stocks[0]  # Assuming the table is the first one on the page
#
#     # Extract stock symbols
#     stock_symbols = most_traded_stocks['Symbol'].tolist()
#
#     # Print the list of stock symbols
#     print(stock_symbols)
#
#     s = []
#     for j in data:
#         # Loop through the stock symbols list from last to first
#         for i in range(len(stock_symbols) -1, 0, -1):
#             print(stock_symbols[i],"===========")
#
#             # Check if the stock symbol matches with the 'j.stockname'
#             if str(stock_symbols[i]) == j.name:
#                 if fav_stock.objects.filter(name=stock_symbols[i], CUSTOMER__AUTH_USER=lid).exists():
#                     a = "yes"
#                     s.append({'name': stock_symbols[i], 'a': a})
#
#     print(s)
#
#     # for i in stock_symbols:
#     #     print(i)
#     #
#     #     s.append(i)
#
#     return JsonResponse({'data': s, 'status': 'ok'})
#
#     # lid=request.POST["lid"]
#     # import pandas as pd
#     # # Fetch most traded stocks from Yahoo Finance
#     #
#     # import pandas as pd
#     # import requests
#     # url_link = 'https://finance.yahoo.com/markets/stocks/most-active/'
#     # r = requests.get(url_link, headers={
#     #     'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'})
#     #
#     # print(r.text)
#     #
#     # most_traded_stocks = pd.read_html(r.text)
#     #
#     #
#     #
#     # ############################
#     #
#     # most_traded_stocks = most_traded_stocks[0]  # Assuming the table is the first one on the page
#     #
#     # # Extract stock symbols
#     # stock_symbols = most_traded_stocks['Symbol'].tolist()
#     #
#     # # Print the list of stock symbols
#     # print(stock_symbols)
#     #
#     # s=[]
#     #
#     # for i in stock_symbols:
#     #     print(i, type(i))
#     #
#     #     if isinstance(i,str):
#     #         pass
#     #     else:
#     #         continue
#     #
#     #
#     #
#     #     s.append({'name':i})
#     #
#     # print(s,"======")
#     #
#     # return JsonResponse({'data':s,'status':'ok'})


# def getfavstock(request):
#
#     lid = request.POST['lid']
#     data = favstock.objects.filter(USER__LOGEIN_id=lid)
#
#
#     import pandas as pd
#     # Fetch most traded stocks from Yahoo Finance
#
#     import pandas as pd
#     import requests
#     url_link = 'https://finance.yahoo.com/markets/stocks/most-active/'
#     r = requests.get(url_link, headers={
#         'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'})
#
#     print(r.text)
#
#     most_traded_stocks = pd.read_html(r.text)
#
#
#
#     ############################
#
#
#
#     # most_traded_stocks = pd.read_html('https://finance.yahoo.com/markets/stocks/most-active/')
#     # most_traded_stocks = pd.read_html('https://finance.yahoo.com/markets/stocks/trending/')
#     # most_traded_stocks = pd.read_html('https://finance.yahoo.com/most-active')
#     most_traded_stocks = most_traded_stocks[0]  # Assuming the table is the first one on the page
#
#     # Extract stock symbols
#     stock_symbols = most_traded_stocks['Symbol'].tolist()
#
#     # Print the list of stock symbols
#     print(stock_symbols)
#
#     s=[]
#     for j in data:
#         # Loop through the stock symbols list from last to first
#         for i in range(len(stock_symbols) - 1, 0, -1):
#             print(stock_symbols[i])
#
#             # Check if the stock symbol matches with the 'j.stockname'
#             if str(stock_symbols[i]) == j.stockname:
#                 if favstock.objects.filter(stockname=stock_symbols[i], USER__LOGEIN_id=lid).exists():
#                     a = "yes"
#                     s.append({'name': stock_symbols[i], 'a': a})
#
#     print(s)
#
#     # for i in stock_symbols:
#     #     print(i)
#     #
#     #     s.append(i)
#
#     return JsonResponse({'data':s,'status':'ok'})

@csrf_exempt
def priceprediction(request):


    name=request.POST["name"]


    import yfinance as yf
    import pandas as pd
    from datetime import datetime
    from sklearn.ensemble import RandomForestRegressor
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import mean_squared_error

    # Fetch live stock market data for a specific stock (e.g., Apple - AAPL)

    cdate = datetime.now().strftime("%Y-%m-%d")
    stock_data = yf.download(name, start='2022-01-01', end=cdate, interval='1d')

    # Assuming 'Close' column contains the target variable (stock prices)
    X = stock_data[['Open', 'High', 'Low', 'Volume']]  # Features
    y = stock_data['Close']  # Target variable

    # Split the data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    # Initialize the Random Forest Regressor
    rf_regressor = RandomForestRegressor(n_estimators=100, random_state=42)#training//
    rf_regressor.fit(X_train, y_train)
    next_day_features = X_test.iloc[-1].values.reshape(1, -1)
    next_day_predictionrf = rf_regressor.predict(next_day_features)#prediction
    print("Predicted next day's stock price:", next_day_predictionrf[0])
    y_pred = rf_regressor.predict(X_test)
    mse_rf = mean_squared_error(y_test, y_pred)
    print("Mean Squared Error:", mse_rf)
    print(X)

    from  sklearn.linear_model import  LinearRegression
    rf_regressor = LinearRegression()
    rf_regressor.fit(X_train, y_train)
    next_day_features = X_test.iloc[-1].values.reshape(1, -1)
    next_day_predictionlf = rf_regressor.predict(next_day_features)
    print("Predicted next day's stock price:", next_day_predictionlf[0])
    y_pred = rf_regressor.predict(X_test)
    mse_lf = mean_squared_error(y_test, y_pred)
    print("Mean Squared Error:", mse_rf)
    print(X)
    print(next_day_predictionlf,'lfffffff')
    print(next_day_predictionrf,"rffffff")

    v=float(next_day_predictionrf[0])+float(next_day_predictionlf[0][0])
    avg=v/2

    print(avg,"aaaaaaaaa")


    return  JsonResponse(
        {
            'status':'ok',
            'rf':str(next_day_predictionrf[0]),
            'lr':str(next_day_predictionlf[0][0]),
            'avg':str(avg),

        }
    )



@csrf_exempt
def buy(req):
    import json
    print("ffffffffffffffffffffffff")
    # from web3 import Web3, HTTPProvider
    # from datetime import datetime
    # blockchain_address = 'http://127.0.0.1:7545'
    # web3 = Web3(HTTPProvider(blockchain_address))
    # web3.eth.defaultAccount = web3.eth.accounts[0]

    # cpath = "C:\\Users\\febin\PycharmProjects\\crowd_funding\\Myapp\\hello\\build\\contracts\\StructDemo.json"
    # deployed_contract_addressa = web3.eth.accounts[0]

    lid=req.POST['lid']
    bb=req.POST['amount']
    stock=req.POST['stock']
    quantity=req.POST['quantity']
    blockaddress = req.POST["address"]
    privatekey = req.POST["private_key"]
    actual = req.POST["actual"]

    print(lid)
    print(stock)
    print(quantity)
    print(blockaddress)
    print(privatekey)

    # print(blockaddress)
    # print(privatekey)
    # amount = 1
    # # amount = req.POST["amount"]
    #
    # toaddress = "0x417cc7a4Bbc6e8FA58563FcB944aE85Cb482807A"
    #
    # abcd = web3.from_wei(int(amount), 'ether')
    # print(abcd)
    #
    # nonce = web3.eth._get_transaction_count(blockaddress)
    #
    # tx = {
    #     'nonce': nonce,
    #     'to': toaddress,
    #     'value': web3.to_wei(amount, 'ether'),
    #     'gas': 200000,
    #     'gasPrice': web3.to_wei('50', 'gwei')
    # }
    # # signedtx = web3.eth.account.sign_transaction(tx, privatekey)
    # # hashx = web3.eth.send_raw_transaction(signedtx.raw_transaction)
    # signedtx = web3.eth.account.sign_transaction(tx,private_key=privatekey)
    # hashx = web3.eth.send_raw_transaction(signedtx.raw_transaction)

    b=Buy()
    b.quantity=quantity
    b.amount=bb
    b.currstockprice=actual
    b.name=stock
    b.date = datetime.datetime.now().today()
    b.CUSTOMER = Customer.objects.get(AUTH_USER=lid)
    b.save()
    # print(web3.to_hex(hashx))

    return JsonResponse({"status": "ok"})



@csrf_exempt
def user_viewbuy(req):
    lid=req.POST['lid']






    a = Buy.objects.filter(CUSTOMER__AUTH_USER_id=lid)
    data = []
    for i in a:
        import yfinance as yd

        cdate = datetime.datetime.now().strftime("%Y-%m-%d")
        # Fetch stock data for one stock (e.g., AAPL for Apple)
        stock_data = yd.download(i.name, start="2026-01-01", end=cdate, interval='1d')

        print(stock_data.values[0][0])

        status="sell"

        if i.currstockprice > stock_data.values[0][0]:
            status="Retain"
        else:
            status="Sell"



        data.append(
            {
                'id':i.id,
               'quantity': i.quantity,
                'amount':i.amount,
                 'date':i.date,
                 'name':i.name,
                 'currstockprice_old':i.currstockprice,
                 'currstockprice':stock_data.values[0][0],
                 'status':status,



            }
        )
    return JsonResponse({'status': 'ok','data':data})





@csrf_exempt
def viewNotification(request):
    nid= request.POST["nid"]

    data=Notification.objects.filter(id__gt=nid).order_by('id')

    if data.exists():

        return  JsonResponse(
            {
                'status':'ok',
                'nid': str(data[0].id),
                'message': data[0].notification
            }

    )
    else:
        return  JsonResponse(
            {
                'status':'no'
            }
        )





def report(req):


    ccount=Complaint.objects.all().count
    customercount=Customer.objects.all().count
    noticount=Notification.objects.all().count
    newscount=News.objects.all().count
    contentcount=Content.objects.all().count
    Videocount=Video.objects.all().count

    return render(req,'Adminpages/report.html',{'ccount':ccount,'customercount':customercount,'noticount':noticount,'newscount':newscount,'contentcount':contentcount,'Videocount':Videocount })


@csrf_exempt
def sell(req):
    lid=req.POST['lid']
    quantity=req.POST["qty"]
    stock=req.POST["stock"]

    a=Sell()
    a.quantity=quantity
    a.stock=stock
    a.CUSTOMER=Customer.objects.get(AUTH_USER_id=lid)
    a.save()

    return JsonResponse({'status': 'ok'})

@csrf_exempt
def viewselled_stock(req):
    lid=req.POST['lid']
    a=Sell.objects.filter(CUSTOMER__AUTH_USER=lid)
    l=[]
    for i in a:
        l.append({
            'id':i.id,
            'stock':i.stock,
            'qty':i.quantity

        })
    print(l)
    return JsonResponse({'status':'ok','data':l})

@csrf_exempt
def android_forget_password_post(request):
    email = request.POST['email']
    if not email:
        return JsonResponse({'status': 'error', 'message': 'Email is required'})

    user = User.objects.get(username=email)
    print(user, "iii")
    print(email)
    print("hhhh")

    # Generate new password
    import random
    new_pass = str(random.randint(1000, 9999))
    user.password = make_password(new_pass)
    user.save()
    print(new_pass)

    # Email configuration
    print("jjjj")
    smtp_server = "smtp.gmail.com"
    smtp_port = 587
    sender_email = "trainingstarted@gmail.com"
    app_password = "nlxasujxgazlbmgz"

    subject = "Your New Password"
    body = f"Your new password is: { new_pass }"
    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = email
    message["Subject"] = subject
    message.attach(MIMEText(body, "plain"))

    server = smtplib.SMTP(smtp_server, smtp_port)
    server.starttls()
    server.login(sender_email, app_password)
    server.send_message(message)
    server.quit()

    return JsonResponse({'status': 'ok', 'message': 'Password sent to your email'})