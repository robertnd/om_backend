package co.ke.vergeinteractive.bizservice.controller;

import co.ke.vergeinteractive.bizservice.auth.AuthService;
import co.ke.vergeinteractive.bizservice.model.dto.response.APIResponse;
import co.ke.vergeinteractive.bizservice.model.dto.transform.OnboardInfo;
import co.ke.vergeinteractive.bizservice.model.entity.RecommendationSummary;
import co.ke.vergeinteractive.bizservice.service.db.DBService;
import co.ke.vergeinteractive.bizservice.service.mv.MVService;
import co.ke.vergeinteractive.bizservice.service.workflow.WorkflowService;
import co.ke.vergeinteractive.bizservice.utils.ApiUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.javatuples.Pair;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.Objects;

@CrossOrigin
@Log4j2
@RestController
@RequiredArgsConstructor
@RequestMapping("/data")
public class DataController {

    private final AuthService authService;
    private final MVService mvService;
    private final WorkflowService task;
    private final DBService dbService;

    @GetMapping(path = "/customer/byid/{idType}/{idNumber}")
    public ResponseEntity<?> getCustomerById(
            @PathVariable("idType") String idType,
            @PathVariable("idNumber") String idNumber,
            @RequestHeader HttpHeaders headers) throws Exception {

        log.info("BizController.getCustomerById - {} - idType - {}, idNumber - {}", idType, idNumber);
        Pair<Boolean, String> checkAuthResult = ApiUtil.checkAuth(headers, token -> authService.validateToken(token));
        if (checkAuthResult.getValue0() == false) {
            log.error("BizController.mvRequest - {} - Authentication failure {} ", checkAuthResult.getValue1());
            return ResponseEntity
                    .status(401)
                    .body(new APIResponse("401", checkAuthResult.getValue1(), "", null));
        }

        OnboardInfo prefill = task.prefill(idType, idNumber, "");
        if (!Objects.isNull(prefill)
                && !Objects.isNull(prefill.getPersonalInfo())) {
            APIResponse customerFound = new APIResponse("200", "Customer found", "", prefill);
            return ResponseEntity.status(HttpStatus.OK).body(customerFound);
        }
        APIResponse notFound = new APIResponse("400", "NOT_FOUND", "", null);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(notFound);
    }

    @GetMapping(path = "/recommendations")
    public ResponseEntity<?> getAllRecommendations(@RequestHeader HttpHeaders headers) throws Exception {

        Pair<Boolean, String> checkAuthResult = ApiUtil.checkAuth(headers, token -> authService.validateToken(token));
        if (checkAuthResult.getValue0() == false) {
            log.error("BizController.mvRequest - {} - Authentication failure {} ", checkAuthResult.getValue1());
            return ResponseEntity
                    .status(401)
                    .body(new APIResponse("401", checkAuthResult.getValue1(), "", null));
        }
        Map<String, RecommendationSummary> allRecommendations = dbService.getAllRecommendations();
        if ( !Objects.isNull(allRecommendations)
                && allRecommendations.size()>0 ) {
            APIResponse recommends = new APIResponse("200", "Success", "", allRecommendations);
            return ResponseEntity.status(HttpStatus.OK).body(recommends);
        }
        APIResponse notFound = new APIResponse("400", "NOT_FOUND", "", null);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(notFound);
    }
}


