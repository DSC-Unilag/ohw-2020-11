import itertools
from datetime import datetime
from rest_framework import status
from rest_framework.generics import ListCreateAPIView, ListAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from .permissions import IsOwner
from .serializers import (
    CRUDIncomeSerializer,
    CRUDExpenseSerializer,
)
from .models import Income, Expense


class CRUDIncomeView(ListCreateAPIView):
    """
    Creates an Income and Gets a list of all incomes ever made
    """
    permission_classes = (IsAuthenticated, IsOwner, )
    serializer_class = CRUDIncomeSerializer

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

    def get_queryset(self):
        user = self.request.user
        my_income = Income.objects.filter(owner=user)
        return my_income


class BudgetIncomeLatestView(ListAPIView):
    """
    Returns the incomes created this month
    """
    permission_classes = (IsAuthenticated, IsOwner)
    serializer_class = CRUDIncomeSerializer

    def get_queryset(self):
        user = self.request.user
        total_income_created_this_month = Income.objects.filter(owner=user, date_created__month=datetime.now().month)
        return total_income_created_this_month


class BudgetIncomeLastView(ListAPIView):
    """
    Returns the incomes created last month
    """
    permission_classes = (IsAuthenticated, IsOwner)
    serializer_class = CRUDIncomeSerializer

    def get_queryset(self):
        user = self.request.user
        total_income_created_this_month = Income.objects.filter(owner=user, date_created__month=datetime.now().month-1)
        return total_income_created_this_month


class CRUDExpenseView(ListCreateAPIView):
    """
    Creates an Expense and Gets a list of all expenses ever made
    """
    permission_classes = (IsAuthenticated, IsOwner, )
    serializer_class = CRUDExpenseSerializer

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

    def get_queryset(self):
        user = self.request.user
        my_expense = Expense.objects.filter(owner=user)
        return my_expense


class BudgetExpenseLatestView(ListAPIView):
    """
    Returns the expenses created this month
    """
    permission_classes = (IsAuthenticated, IsOwner)
    serializer_class = CRUDExpenseSerializer

    def get_queryset(self):
        user = self.request.user
        total_expense_created_this_month = Expense.objects.filter(owner=user, date_created__month=datetime.now().month)
        return total_expense_created_this_month


class BudgetExpenseLastView(ListAPIView):
    """
    Returns the expenses created last month
    """
    permission_classes = (IsAuthenticated, IsOwner)
    serializer_class = CRUDExpenseSerializer

    def get_queryset(self):
        user = self.request.user
        total_expense_created_last_month = Expense.objects.filter(owner=user, date_created__month=datetime.now().month-1)
        return total_expense_created_last_month


class IncomeSumView(APIView):
    """
    Sum of all Income created this month
    """

    def get(self, request):
        user = request.user
        this_month = datetime.now().month
        total_sum_of_income_this_month = sum([i.amount for i in Income.objects.filter(owner=user, date_created__month=this_month)])
        return Response(total_sum_of_income_this_month)


class ExpenseSumView(APIView):
    """
    Sum of all Expenses created this month
    """

    def get(self, request):
        user = request.user
        this_month = datetime.now().month
        total_sum_of_expense_this_month = sum([i.amount for i in Expense.objects.filter(owner=user, date_created__month=this_month)])
        return Response(total_sum_of_expense_this_month)


class TotalBudgetView(APIView):
    """
    Returns the total Budget Spent in a month (Income - Expense)
    """
    def get(self, request):
        user = request.user
        this_month = datetime.now().month
        total_sum_of_income_this_month = sum([i.amount for i in Income.objects.filter(owner=user, date_created__month=this_month)])
        total_sum_of_expense_this_month = sum([i.amount for i in Expense.objects.filter(owner=user, date_created__month=this_month)])
        budget = (total_sum_of_income_this_month - total_sum_of_expense_this_month)
        return Response(budget)
