package com.swcmanager.controller;

import com.swcmanager.dao.CohortDao;
import com.swcmanager.model.Cohort;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import org.springframework.beans.propertyeditors.CustomDateEditor;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SWCCohortController {

    private CohortDao cohortDao;

    @Inject
    public SWCCohortController(CohortDao cohortDao) {
        this.cohortDao = cohortDao;
    }

    @RequestMapping(value = "/cohortList", method = RequestMethod.GET)
    public String displayCohortList(Map<String, Object> model) {
        Cohort[] coArray = cohortDao.displayCohorts();
        model.put("cohortList", coArray);
        return "displayCohortList";
    }

    @RequestMapping(value = "/deleteCohort", method = RequestMethod.GET)
    public String deleteCohort(@RequestParam("cohortId") String id,
            Map<String, Object> model) {

        cohortDao.deleteCohort(Integer.parseInt(id));

        return "redirect:cohortList";
    }

    /**
     *
     * @param req
     * @param res
     * @param model
     * @return
     * @throws java.text.ParseException
     */
    @RequestMapping(value = "/addCohort", method = RequestMethod.POST)
    public String addCohort(HttpServletRequest req,
            HttpServletResponse res,
            Map<String, Object> model) {

        //create a cohort and fill it with stuff from the add cohort form
        Cohort co = new Cohort();
        co.setTrack(req.getParameter("track"));

        //for validating the date field on add cohort
        String startDate = req.getParameter("startDate");
        if (startDate.matches("\\d{4}-\\d{2}-\\d{2}")) {

            //try catch to make sure a valid date is entered
            try {
                co.setStartDate(new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(startDate));
            } catch (ParseException ex) {
                model.put("validDate", "Please enter a valid date");
                model.put("addCohortPopup", true);
                return "displayCohortList";
            }
        } else {
            model.put("validDate", "Please enter a valid date");
            model.put("addCohortPopup", true);
            return "displayCohortList";
        }

        //add the cohort to the database
        cohortDao.addCohort(co);

        //return to the main display page
        return "redirect:cohortList";
    }

    @RequestMapping(value = "/editCohortForm", method = RequestMethod.GET)
    public String editCohort(HttpServletRequest req,
            HttpServletResponse res, Map<String, Object> model) {

        int cohortId = Integer.parseInt(req.getParameter("cohortId"));
        Cohort cohort = cohortDao.getCohort(cohortId);

        String[] trackList = {"Java", ".Net"};

        model.put("trackList", trackList);
        model.put("cohort", cohort);
        return "displayEditCohort";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    @RequestMapping(value = "/editCohort", method = RequestMethod.POST)
    public String performEdit(@Valid Cohort cohort, Map<String, Object> model,
            HttpServletRequest req, BindingResult result) {

        if(result.hasErrors()){
            String[] trackList = {"Java", ".Net"};

            model.put("trackList", trackList);
            model.put("validDate", "Please enter a valid date");
            model.put("cohort", cohort);
            return "displayEditCohort";
        }
        
//        //try catch to make sure a valid date is entered
//        try {
//            new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse(req.getParameter("startDate"));
//
//        } catch (ParseException ex) {
//            String[] trackList = {"Java", ".Net"};
//
//            model.put("trackList", trackList);
//            model.put("validDate", "Please enter a valid date");
//            model.put("cohort", cohort);
//            return "displayEditCohort";
//        }

        cohortDao.updateCohort(cohort);

        Cohort[] coArray = cohortDao.displayCohorts();
        model.put("cohortList", coArray);

        return "redirect:cohortList";
    }
}
