# Generated by Django 4.0.2 on 2022-04-07 06:45

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0019_remove_savedhostel_hostelcity_and_more'),
    ]

    operations = [
        migrations.DeleteModel(
            name='SavedHostel',
        ),
    ]
