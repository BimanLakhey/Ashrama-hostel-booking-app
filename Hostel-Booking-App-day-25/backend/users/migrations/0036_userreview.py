# Generated by Django 4.0.2 on 2022-04-19 15:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0035_bookedhostel'),
    ]

    operations = [
        migrations.CreateModel(
            name='UserReview',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('userID', models.CharField(max_length=50)),
                ('hostelID', models.CharField(max_length=50)),
                ('rating', models.CharField(max_length=50)),
                ('review', models.CharField(max_length=200)),
                ('reviewDate', models.DateField()),
            ],
        ),
    ]
