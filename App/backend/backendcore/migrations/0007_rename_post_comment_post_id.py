# Generated by Django 4.2 on 2023-04-26 13:23

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('backendcore', '0006_comment_created_at_comment_user_id_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='comment',
            old_name='Post',
            new_name='post_id',
        ),
    ]