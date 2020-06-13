package ru.kpfu.itis.kevlinsky.services;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import ru.kpfu.itis.kevlinsky.dto.PostDto;
import sun.security.x509.AttributeNameEnumeration;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
public class MainService {
    @Value("vk.api.token")
    private String url;

      public List<PostDto> getPosts(){
        RestTemplateBuilder restTemplateBuilder = new RestTemplateBuilder();
        RestTemplate restTemplate = restTemplateBuilder.build();
        String plainJSON = restTemplate.getForObject(url, String.class);
        List<PostDto> posts = new ArrayList<>();
          try {
              JsonNode node = (new ObjectMapper()).readValue(plainJSON, JsonNode.class);
              List<JsonNode> itemsNodes = node.findValues("items");
              for(JsonNode jsonNode: itemsNodes){
                  List<String> urls = new ArrayList<>();
                  for(JsonNode attachment: jsonNode.findValues("attachments")){
                      JsonNode photoNode = attachment.findValue("photo");
                      if (photoNode != null){
                          List<JsonNode> sizes = photoNode.findValues("sizes");
                          JsonNode urlNode = attachment.findValue("photo").findValues("sizes").get(sizes.size() - 1).findValue("url");
                          if (urlNode != null){
                              urls.add(urlNode.asText());
                          }
                      }
                  }
                  PostDto postDto = PostDto.builder().text(jsonNode.findValue("text").asText()).photos(urls).build();
                  posts.add(postDto);
              }
          } catch (JsonProcessingException e) {
              throw new IllegalArgumentException();
          }
        return posts;
      }
}
