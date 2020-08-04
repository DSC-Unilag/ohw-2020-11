from django.urls import path
from .views import (
    CRUDExpenseView,
    CRUDIncomeView,
    BudgetIncomeLatestView,
    BudgetIncomeLastView,
    BudgetExpenseLastView,
    BudgetExpenseLatestView,
    IncomeSumView,
    ExpenseSumView,
    TotalBudgetView,
)

urlpatterns = [
    path('income/', CRUDIncomeView.as_view()),
    path('expense/', CRUDExpenseView.as_view()),
    path('income/latest-month/', BudgetIncomeLatestView.as_view()),
    path('income/last-month/', BudgetIncomeLastView.as_view()),
    path('income/sum-of-the-month/', IncomeSumView.as_view()),
    path('expense/latest-month/', BudgetExpenseLatestView.as_view()),
    path('expense/last-month/', BudgetExpenseLastView.as_view()),
    path('expense/sum-of-the-month/', ExpenseSumView.as_view()),
    path('month-budget/', TotalBudgetView.as_view()),
]
