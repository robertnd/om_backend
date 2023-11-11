package co.ke.vergeinteractive.loginservice.utils;

import com.amazonaws.services.sns.model.MessageAttributeValue;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class Utils {

    public static <T> Set<T> createSet (T... items) {
        Set<T> genSet = new HashSet<>();
        for (T item : items) {
            try {
                genSet.add(item);
            } catch (Exception e) {
            } // ignore repetitions
        }
        return genSet;
    }

    public static Map<String, MessageAttributeValue> getAttributes(String senderID) {
        Map<String, MessageAttributeValue> attributes = new HashMap<>();
//        attributes.put("AWS.SNS.SMS.SenderID", new MessageAttributeValue()
//                .withStringValue(senderID)
//                .withDataType("String"));
        attributes.put("AWS.SNS.SMS.SMSType", new MessageAttributeValue()
                .withStringValue("Transactional")
                .withDataType("String"));

        return attributes;
    }
}
