<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>수영장 지도</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
    }
    .header {
      padding: 10px 20px;
      background-color: #f2f2f2;
    }
    #map {
      height: calc(100vh - 50px);
      width: 100%;
    }
    .loading {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      text-align: center;
      z-index: 100;
      background: rgba(255, 255, 255, 0.8);
      padding: 20px;
      border-radius: 5px;
    }
    #status {
      padding: 10px;
      background-color: #f9f9f9;
      border-bottom: 1px solid #ddd;
    }
  </style>
</head>
<body>
<div class="header">
  <h3>내 주변 수영장 찾기</h3>
</div>
<div id="status">검색 상태: 준비 중...</div>
<div id="loading" class="loading">위치 정보를 가져오는 중...</div>
<div id="map"></div>

<script>
  let map, service;
  let markersCount = 0;

  // 지도 초기화 함수
  function initMap() {
    document.getElementById('loading').style.display = 'block';
    document.getElementById('status').innerHTML = "검색 상태: 위치 정보 가져오는 중...";

    // 사용자의 현재 위치 가져오기
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
              function(position) {
                const userLocation = {
                  lat: position.coords.latitude,
                  lng: position.coords.longitude
                };

                document.getElementById('loading').style.display = 'none';
                document.getElementById('status').innerHTML = "검색 상태: 위치 확인 완료, 지도 로딩 중...";

                // 지도 생성
                map = new google.maps.Map(document.getElementById("map"), {
                  center: userLocation,
                  zoom: 13,  // 조금 더 확대
                  mapTypeControl: true,
                  fullscreenControl: true,
                  streetViewControl: true
                });

                // 사용자 위치 마커 추가
                const userMarker = new google.maps.Marker({
                  position: userLocation,
                  map: map,
                  title: "내 위치",
                  icon: "https://maps.google.com/mapfiles/ms/icons/blue-dot.png"
                });

                document.getElementById('status').innerHTML = "검색 상태: 주변 수영장 검색 중...";

                // 수영장 찾기 - 여러 키워드와 방법으로 검색 시도
                searchWithMultipleTerms(userLocation);
              },
              function(error) {
                document.getElementById('loading').style.display = 'none';

                // 오류 코드에 따른 메시지 표시
                let errorMessage;
                switch(error.code) {
                  case error.PERMISSION_DENIED:
                    errorMessage = "위치 정보 접근 권한이 거부되었습니다.";
                    break;
                  case error.POSITION_UNAVAILABLE:
                    errorMessage = "위치 정보를 사용할 수 없습니다.";
                    break;
                  case error.TIMEOUT:
                    errorMessage = "위치 정보 요청 시간이 초과되었습니다.";
                    break;
                  default:
                    errorMessage = "알 수 없는 오류가 발생했습니다.";
                }

                document.getElementById('status').innerHTML = "오류: " + errorMessage;
                alert(errorMessage);

                // 기본 위치로 지도 표시 (서울)
                const defaultLocation = { lat: 37.5665, lng: 126.9780 };
                map = new google.maps.Map(document.getElementById("map"), {
                  center: defaultLocation,
                  zoom: 12
                });

                // 서울 중심에서 수영장 검색
                searchWithMultipleTerms(defaultLocation);
              }
      );
    } else {
      document.getElementById('loading').style.display = 'none';
      document.getElementById('status').innerHTML = "오류: 이 브라우저는 위치 서비스를 지원하지 않습니다.";
      alert("이 브라우저는 위치 서비스를 지원하지 않습니다.");

      // 기본 위치로 지도 표시 (서울)
      const defaultLocation = { lat: 37.5665, lng: 126.9780 };
      map = new google.maps.Map(document.getElementById("map"), {
        center: defaultLocation,
        zoom: 12
      });

      // 서울 중심에서 수영장 검색
      searchWithMultipleTerms(defaultLocation);
    }
  }

  // 여러 키워드로 검색 시도
  function searchWithMultipleTerms(location) {
    service = new google.maps.places.PlacesService(map);

    // 다양한 검색어로 시도
    const searchTerms = [
      { keyword: "수영장", type: null },
      { keyword: "실내 수영장", type: null },
      { keyword: "swimming pool", type: null },
      { keyword: "수영", type: ['gym', 'health'] },
      { keyword: "체육센터 수영", type: null },
      { keyword: "50플러스 수영", type: null },
      { keyword: "다이빙", type: null }
    ];

    // 순차적으로 모든 검색어로 시도
    for (let i = 0; i < searchTerms.length; i++) {
      setTimeout(function() {
        performSearch(location, searchTerms[i].keyword, searchTerms[i].type, i);
      }, i * 1000); // 각 검색은 1초 간격으로 실행
    }

    // 모든 검색이 끝난 후 확인
    setTimeout(function() {
      if (markersCount === 0) {
        document.getElementById('status').innerHTML = "검색 결과: 주변에 수영장을 찾을 수 없습니다. 다른 지역을 시도해보세요.";
        // 직접 검색 기능 추가
        addSearchBox();
      } else {
        document.getElementById('status').innerHTML = "검색 결과: " + markersCount + "개의 수영장을 찾았습니다.";
      }
    }, (searchTerms.length + 1) * 1000);
  }

  // 검색 박스 추가
  function addSearchBox() {
    const searchDiv = document.createElement('div');
    searchDiv.style.padding = '10px';
    searchDiv.style.backgroundColor = 'white';
    searchDiv.style.position = 'absolute';
    searchDiv.style.top = '100px';
    searchDiv.style.left = '10px';
    searchDiv.style.zIndex = '5';
    searchDiv.style.boxShadow = '0 2px 6px rgba(0,0,0,0.3)';

    searchDiv.innerHTML =
            '<input id="search-input" type="text" placeholder="지역명 + 수영장 검색" style="width:200px; padding:5px;">' +
            '<button id="search-button" style="margin-left:5px; padding:5px;">검색</button>';

    document.body.appendChild(searchDiv);

    document.getElementById('search-button').addEventListener('click', function() {
      const searchText = document.getElementById('search-input').value;
      if (searchText.trim() !== '') {
        textSearch(searchText);
      }
    });

    // Enter 키 이벤트
    document.getElementById('search-input').addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
        const searchText = document.getElementById('search-input').value;
        if (searchText.trim() !== '') {
          textSearch(searchText);
        }
      }
    });
  }

  // 텍스트 검색
  function textSearch(query) {
    document.getElementById('status').innerHTML = "검색 중: " + query;
    service.textSearch({
      query: query,
      radius: 50000  // 더 넓은 반경 (50km)
    }, function(results, status) {
      if (status === google.maps.places.PlacesServiceStatus.OK && results.length > 0) {
        // 기존 마커 초기화
        clearMarkers();
        markersCount = 0;

        // 새 마커 추가
        results.forEach(function(place) {
          createMarker(place);
        });

        // 첫 번째 결과로 지도 중심 이동
        map.setCenter(results[0].geometry.location);
        document.getElementById('status').innerHTML = "검색 결과: " + results.length + "개의 장소를 찾았습니다.";
      } else {
        document.getElementById('status').innerHTML = "검색 결과가 없습니다: " + status;
      }
    });
  }

  // 마커 초기화 (모든 마커 삭제)
  let markers = [];
  function clearMarkers() {
    markers.forEach(function(marker) {
      marker.setMap(null);
    });
    markers = [];
  }

  // 검색 수행 함수
  function performSearch(userLocation, keyword, type, index) {
    document.getElementById('status').innerHTML = "검색 중: " + keyword + "...";

    const request = {
      location: userLocation,
      radius: 15000, // 15km로 확장
      keyword: keyword
    };

    // type이 있으면 추가
    if (type) {
      request.type = type;
    }

    service.nearbySearch(request, function(results, status) {
      if (status === google.maps.places.PlacesServiceStatus.OK && results.length > 0) {
        document.getElementById('status').innerHTML = "'" + keyword + "' 검색 결과: " + results.length + "개 발견";

        results.forEach(function(place) {
          createMarker(place);
        });

        markersCount += results.length;
      } else {
        console.log('"' + keyword + '" 검색 결과 없음:', status);
        document.getElementById('status').innerHTML = "'" + keyword + "' 검색 결과: 없음";

        // 마지막 검색어로도 결과가 없으면 텍스트 검색 시도
        if (index === 4 && markersCount === 0) {
          // 현재 위치 주변 도시명 + 수영장으로 검색
          const geocoder = new google.maps.Geocoder();
          geocoder.geocode({ 'location': userLocation }, function(results, status) {
            if (status === 'OK' && results[0]) {
              // 주소에서 도시/구 이름 추출 시도
              let locality = "";
              for (let i = 0; i < results[0].address_components.length; i++) {
                const component = results[0].address_components[i];
                if (component.types.includes('locality') ||
                        component.types.includes('sublocality_level_1') ||
                        component.types.includes('administrative_area_level_1')) {
                  locality = component.long_name;
                  break;
                }
              }

              if (locality) {
                // 도시명 + 수영장으로 검색
                textSearch(locality + " 수영장");
              }
            }
          });
        }
      }
    });
  }

  // 마커 생성 및 클릭 이벤트 처리
  function createMarker(place) {
    // 중복 마커 방지 (같은 위치의 마커가 이미 있는지 확인)
    for (let i = 0; i < markers.length; i++) {
      if (markers[i].getPosition().equals(place.geometry.location)) {
        return; // 중복된 위치면 추가하지 않음
      }
    }

    const marker = new google.maps.Marker({
      position: place.geometry.location,
      map: map,
      title: place.name,
      animation: google.maps.Animation.DROP
    });

    // 마커 배열에 추가
    markers.push(marker);

    const detailRequest = {
      placeId: place.place_id,
      fields: ['name', 'geometry', 'formatted_address', 'formatted_phone_number', 'website', 'opening_hours', 'rating', 'photos']
    };

    // 마커 클릭 시 상세 정보 가져오기
    marker.addListener("click", function() {
      service.getDetails(detailRequest, function(placeDetail, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          // 전통적인 문자열 연결 방식 사용
          let content = '<div style="min-width:200px;max-width:300px">' +
                  '<h3>' + (placeDetail.name || "이름 없음") + '</h3>';

          // 사진이 있으면 첫 번째 사진 표시
          if (placeDetail.photos && placeDetail.photos.length > 0) {
            content += '<img src="' + placeDetail.photos[0].getUrl({maxWidth: 200, maxHeight: 150}) + '" style="width:100%;max-height:150px;object-fit:cover;">';
          }

          if (placeDetail.formatted_address) {
            content += '<p><strong>주소:</strong> ' + placeDetail.formatted_address + '</p>';
          }

          if (placeDetail.formatted_phone_number) {
            content += '<p><strong>전화번호:</strong> ' + placeDetail.formatted_phone_number + '</p>';
          }

          if (placeDetail.rating) {
            content += '<p><strong>평점:</strong> ' + placeDetail.rating + '/5</p>';
          }

          if (placeDetail.website) {
            content += '<p><a href="' + placeDetail.website + '" target="_blank">웹사이트 방문</a></p>';
          }

          if (placeDetail.opening_hours && placeDetail.opening_hours.weekday_text) {
            content += '<p><strong>영업시간:</strong><br>';
            for (let i = 0; i < placeDetail.opening_hours.weekday_text.length; i++) {
              content += placeDetail.opening_hours.weekday_text[i] + '<br>';
            }
            content += '</p>';
          }

          // 네이버 지도 링크 추가
          const lat = placeDetail.geometry.location.lat();
          const lng = placeDetail.geometry.location.lng();
          content += '<p>' +
                  '<a href="https://map.naver.com/p/search/' + encodeURIComponent(placeDetail.name) + '" target="_blank">네이버 지도에서 보기</a><br>' +
                  '<a href="https://map.kakao.com/link/search/' + encodeURIComponent(placeDetail.name) + '" target="_blank">카카오 지도에서 보기</a><br>' +
                  '<a href="https://maps.google.com/maps?daddr=' + lat + ',' + lng + '&amp;ll=" target="_blank">길찾기</a>' +
                  '</p>';

          content += '</div>';

          const infoWindow = new google.maps.InfoWindow({
            content: content
          });

          infoWindow.open({
            anchor: marker,
            map: map,
            shouldFocus: false
          });
        }
      });
    });
  }
</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=${googleMapKey}&libraries=places,geocoding&callback=initMap&language=ko">
</script>
</body>
</html>