# Generated by Django 4.0.2 on 2022-04-14 13:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0033_remove_hostel_hostelownerid'),
    ]

    operations = [
        migrations.DeleteModel(
            name='BookedHostel',
        ),
        migrations.AlterField(
            model_name='hostel',
            name='hostelPhoto',
            field=models.ImageField(default='defaultHostel.jpg', null=True, upload_to=''),
        ),
    ]
