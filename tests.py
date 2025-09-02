"""
Basic tests for the Ya-Note project
"""

import pytest
from django.test import TestCase, Client
from django.contrib.auth.models import User
from django.urls import reverse
from notes.models import Note


class TestBasicFunctionality(TestCase):
    """Basic functionality tests"""

    def setUp(self):
        """Initial setup for tests"""
        self.client = Client()
        self.user = User.objects.create_user(
            username="testuser", password="testpass123"
        )

    def test_home_page_loads(self):
        """Tests if the home page loads correctly"""
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_user_can_login(self):
        """Tests if the user can log in"""
        response = self.client.post(
            "/auth/login/", {"username": "testuser", "password": "testpass123"}
        )
        # Should redirect after successful login
        self.assertEqual(response.status_code, 302)

    def test_user_registration(self):
        """Tests if new users can register"""
        response = self.client.post(
            "/auth/signup/",
            {
                "username": "newuser",
                "password1": "complexpass123",
                "password2": "complexpass123",
            },
        )
        # Should redirect after successful registration
        self.assertEqual(response.status_code, 302)
        # Checks if the user was created
        self.assertTrue(User.objects.filter(username="newuser").exists())


class TestNoteModel(TestCase):
    """Tests for the Note model"""

    def setUp(self):
        """Initial setup for tests"""
        self.user = User.objects.create_user(
            username="testuser", password="testpass123"
        )

    def test_note_creation(self):
        """Tests the creation of a new note"""
        note = Note.objects.create(
            title="Test", text="Test content", author=self.user
        )
        self.assertEqual(note.title, "Test")
        self.assertEqual(note.author, self.user)
        self.assertTrue(note.slug)  # Slug should be generated automatically

    def test_note_slug_generation(self):
        """Tests automatic slug generation"""
        note = Note.objects.create(
            title="Title with Accents", text="Content", author=self.user
        )
        # Slug should be generated from the title
        self.assertIsNotNone(note.slug)
        self.assertNotEqual(note.slug, "")


class TestNoteViews(TestCase):
    """Tests for note views"""

    def setUp(self):
        """Initial setup for tests"""
        self.client = Client()
        self.user = User.objects.create_user(
            username="testuser", password="testpass123"
        )
        self.note = Note.objects.create(
            title="Test Note", text="Note content", author=self.user
        )

    def test_notes_list_requires_login(self):
        """Tests if the notes list requires login"""
        response = self.client.get("/notes/")
        # Should redirect to login
        self.assertEqual(response.status_code, 302)

    def test_authenticated_user_can_view_notes(self):
        """Tests if authenticated user can view their notes"""
        self.client.login(username="testuser", password="testpass123")
        response = self.client.get("/notes/")
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Test Note")

    def test_user_only_sees_own_notes(self):
        """Tests if user only sees their own notes"""
        # Create another user and their note
        other_user = User.objects.create_user(
            username="otheruser", password="otherpass123"
        )
        other_note = Note.objects.create(
            title="Other's Note", text="Content", author=other_user
        )

        # Log in with the first user
        self.client.login(username="testuser", password="testpass123")
        response = self.client.get("/notes/")

        # Should only see their own note
        self.assertContains(response, "Test Note")
        self.assertNotContains(response, "Other's Note")


@pytest.mark.django_db
def test_django_setup():
    """Simple test to check if Django is configured correctly"""
    from django.conf import settings

    assert settings.configured
    assert "notes" in settings.INSTALLED_APPS
