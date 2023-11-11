package co.ke.vergeinteractive.loginservice.controllers;

import co.ke.vergeinteractive.loginservice.model.dto.request.SendRequest;
import co.ke.vergeinteractive.loginservice.utils.Utils;
import com.amazonaws.services.sns.AmazonSNS;
import com.amazonaws.services.sns.model.MessageAttributeValue;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@CrossOrigin
@RestController
@RequestMapping("/sms")
@RequiredArgsConstructor
public class NotificationController {

    private final AmazonSNS snsClient;

    @Value("${sns.sender_id}")
    private String senderId;

    @PostMapping("/send")
    public ResponseEntity<?> sendMessage(@RequestBody SendRequest request) {

        Map<String, MessageAttributeValue> attributes = Utils.getAttributes(senderId);
        PublishResult publishResult = snsClient.publish(new PublishRequest()
                .withMessage(request.getMessage())
                .withPhoneNumber(request.getPhoneNumber())
                .withMessageAttributes(attributes));

        return ResponseEntity
                .ok()
                .body(publishResult.getMessageId());
    }
}
