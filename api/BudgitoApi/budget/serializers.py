from rest_framework import serializers
from .models import Expense, Income


class CRUDIncomeSerializer(serializers.ModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Income
        fields = (
            'owner', 'amount', 'category', 'description',
        )
        read_only_fields = (
            'date_created', 'time_created', 'created',
        )

    def create(self, validated_data):
        income = Income.objects.create(**validated_data)
        return income

    def update(self, instance, validated_data):
        instance.amount = validated_data('amount', instance.amount)
        instance.category = validated_data('category', instance.category)
        instance.description = validated_data('description', instance.description)
        instance.save()

    def to_internal_value(self, data):
        amount = data.get('amount')
        category = data.get('category')
        description = data.get('description')

        if not amount:
            raise serializers.ValidationError({
                'amount': 'This field is required.'
            })

        if float(amount) <= 0.00:
            raise serializers.ValidationError({
                'amount': 'Field must not be less than 0.00'
            })

        if not category:
            raise serializers.ValidationError({
                'category': 'This field is required.'
            })

        if not description:
            raise serializers.ValidationError({
                'description': 'This field is required.'
            })

        return {
            'amount': float(amount),
            'category': category,
            'description': description,
        }


class CRUDExpenseSerializer(serializers.ModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Expense
        fields = (
            'owner', 'amount', 'category', 'description',
        )
        read_only_fields = (
            'date_created', 'time_created', 'created',
        )

    def create(self, validated_data):
        expense = Expense.objects.create(**validated_data)
        return expense

    def update(self, instance, validated_data):
        instance.amount = validated_data('amount', instance.amount)
        instance.category = validated_data('category', instance.category)
        instance.description = validated_data('description', instance.description)
        instance.save()

    def to_internal_value(self, data):
        amount = data.get('amount')
        category = data.get('category')
        description = data.get('description')

        if not amount:
            raise serializers.ValidationError({
                'amount': 'This field is required.'
            })

        if float(amount) <= 0.00:
            raise serializers.ValidationError({
                'amount': 'Field must not be less than 0.00.'
            })

        if not category:
            raise serializers.ValidationError({
                'category': 'This field is required.'
            })

        if not description:
            raise serializers.ValidationError({
                'description': 'This field is required.'
            })

        return {
            'amount': int(amount),
            'category': category,
            'description': description,
        }

