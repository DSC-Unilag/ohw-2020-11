from datetime import datetime
from django.db import models
from django.contrib.auth.models import User
from django.db.models import Count


class Income(models.Model):

    INCOME_CATEGORY = (
        ('Allowance', 'ALLOWANCE'),
        ('Salary', 'SALARY'),
        ('Freelance gig', 'FREELANCE_GIG'),
        ('Gifted', 'GIFTED'),
        ('Others', 'OTHERS'),
    )

    owner = models.ForeignKey(User, related_name='income', on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)
    date_created = models.DateField(auto_now_add=True)
    time_created = models.TimeField(auto_now_add=True)
    amount = models.DecimalField(verbose_name='Amount?', default=0.00, max_digits=10, decimal_places=2)
    category = models.TextField(choices=INCOME_CATEGORY, default='Allowance')
    description = models.CharField(
        max_length=500,
        help_text='A short description on how I got this income',
        default='my monthly allowance'
    )

    def __str__(self):
        return '%s - %s' % (self.owner, self.category)

    class Meta:
        ordering = ['-created']

    @property
    def total_monthly_income(self):
        this_month = datetime.now().month
        this_month_income = Income.objects.filter(date_created__month=this_month)
        inc = sum([inc.amount for inc in this_month_income])
        # total = this_month_income
        return inc

    @property
    def number_of_income(self):
        this_month = datetime.now().month
        this = Income.objects.filter(date_created__month=this_month)
        owner_object = Income.objects.filter(owner=self.owner.id)
        number_of_income = Count(this and owner_object)
        return number_of_income


class Expense(models.Model):

    EXPENSE_CATEGORY = (
        ('Entertainment', 'ENTERTAINMENT'),
        ('Transport', 'TRANSPORT'),
        ('Network', 'NETWORK'),
        ('Food', 'FOOD'),
        ('Shoes', 'SHOES'),
        ('Others', 'OTHERS'),
    )

    owner = models.ForeignKey(User, related_name='expense', on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)
    date_created = models.DateField(auto_now_add=True)
    time_created = models.TimeField(auto_now_add=True)
    modified = models.DateTimeField()
    amount = models.DecimalField(verbose_name='Amount?', default=0.00, max_digits=10, decimal_places=2)
    category = models.TextField(choices=EXPENSE_CATEGORY, default='Entertainment')
    description = models.CharField(
        max_length=500,
        help_text='A short description on how I got this expense',
        default='Went to see a Movie'
    )

    def __str__(self):
        return '%s - %s' % (self.owner, self.amount)

    class Meta:
        ordering = ['-created']

    @property
    def total_monthly_expense(self):
        this_month = datetime.now().month
        this_month_expense = Expense.objects.filter(date_created__month=this_month)
        total = sum(this_month_expense.amount)
        return total

    @property
    def number_of_expense(self):
        this_month = datetime.now().month
        number_of_expense = Count(Expense.objects.filter(date_created__month=this_month))
        return number_of_expense

