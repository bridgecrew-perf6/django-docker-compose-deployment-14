from django.shortcuts import render
from django.views.generic import TemplateView

def index_wrapper(request):
    return render(request, 'index.html', {'foo': 'bar'})


class AboutusView(TemplateView):
	template_name = 'core/about-us.html'
