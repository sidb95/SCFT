# Generated by Django 5.0.6 on 2024-06-09 08:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('CFMaps', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='city',
            name='uid',
            field=models.IntegerField(auto_created=True, unique=True),
        ),
    ]
