# Generated by Django 4.2 on 2023-04-28 14:22

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('backendcore', '0008_alter_comment_id_alter_comment_post_id_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='MarketPlacePost',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('material', models.CharField(max_length=255)),
                ('price', models.FloatField()),
                ('quantity', models.IntegerField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('user_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]