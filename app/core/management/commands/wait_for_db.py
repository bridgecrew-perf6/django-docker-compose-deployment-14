"""
Django command to wait for the database to be available
"""

from psycopg2 import OperationalError as Psycopg2OpError
from django.db.utils import OperationalError
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    """Django command to wait for database"""

    def handle(self, *args, **kwargs):
        """
        Entry point for the command
        """
        self.stdout.write('Waiting for database...')
        db_up = False

        while db_up is False:
            try:
                self.check(databases=['default'])
                db_up = True
            except (Psycopg2OpError, OperationalError) as err:
                self.stdout.write('Databse not available yet, waiting one second...')
                time.sleep(1)

        self.stdout.write('Databse ready.')
