# Generated by Django 4.0.2 on 2022-04-04 10:16

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0016_remove_savedhostel_hostelname'),
    ]

    operations = [
        migrations.DeleteModel(
            name='SavedHostel',
        ),
    ]
