
String key = 'your_key_here';
String trendingApi = 'https://api.giphy.com/v1/gifs/trending?api_key=$key&limit=20&rating=G';
String gifAppbar = 'https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif';



String searchApi(String query, int offset){
return 'https://api.giphy.com/v1/gifs/search?api_key=$key&q=$query&limit=19&offset=$offset&rating=G&lang=en';

}

