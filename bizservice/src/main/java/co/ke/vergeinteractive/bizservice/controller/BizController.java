package co.ke.vergeinteractive.bizservice.controller;

import co.ke.vergeinteractive.bizservice.auth.AuthService;
import co.ke.vergeinteractive.bizservice.model.dto.response.APIResponse;
import co.ke.vergeinteractive.bizservice.model.dto.transform.OnboardInfo;
import co.ke.vergeinteractive.bizservice.model.entity.Recommendation;
import co.ke.vergeinteractive.bizservice.service.db.DBService;
import co.ke.vergeinteractive.bizservice.service.mv.MVService;
import co.ke.vergeinteractive.bizservice.service.workflow.WorkflowService;
import co.ke.vergeinteractive.bizservice.utils.ApiUtil;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.javatuples.Pair;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin
@Log4j2
@RestController
@RequiredArgsConstructor
@RequestMapping("/onboard")
public class BizController {

    private final AuthService authService;
    private final MVService mvService;
    private final WorkflowService task;
    Gson gson = ApiUtil.gsonBuilder();

    @PostMapping(path = "/motorvehicle")
    public ResponseEntity<?> mvRequest(
            @RequestBody final Object request,
            @RequestHeader HttpHeaders headers) throws Exception {

        String internalTrackingRef = ApiUtil.generateRef();
        log.info("BizController.mvRequest - {} - (START) Raw Request - {}", internalTrackingRef, request);
        Pair<Boolean, String> checkAuthResult = ApiUtil.checkAuth(headers, token -> authService.validateToken(token));
        if (checkAuthResult.getValue0() == false) {
            log.error("BizController.mvRequest - {} - Authentication failure {} ", internalTrackingRef, checkAuthResult.getValue1());
            return ResponseEntity
                    .status(401)
                    .body(new APIResponse("401", checkAuthResult.getValue1(), "", null));
        }

        task.onboard(request,internalTrackingRef);
        APIResponse apiResponse = mvService.mvProxy(request, internalTrackingRef);
        log.info("BizController.mvRequest - {} - (END) API response - {}",  internalTrackingRef,gson.toJson(apiResponse));

        if (apiResponse.getStatusCode().equalsIgnoreCase("200")) {
            return ResponseEntity.status(HttpStatus.OK).body(apiResponse);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(apiResponse);
        }
    }
}
