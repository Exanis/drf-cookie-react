from rest_framework import response, decorators, status


@decorators.api_view(['GET'])
def health(request):
    return response.Response(status=status.HTTP_200_OK)
