from django.http import HttpResponse


def sync_view(request):
    return HttpResponse("Hello, world. You're at the polls index.")


async def async_view(request):
    return HttpResponse("Hello, world. You're at the polls index.")
