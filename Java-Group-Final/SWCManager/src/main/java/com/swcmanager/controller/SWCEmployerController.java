package com.swcmanager.controller;

import com.swcmanager.dao.EmployerDao;
import com.swcmanager.model.Contact;
import com.swcmanager.model.Employer;
import com.swcmanager.model.Payment;
import com.swcmanager.model.Work;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SWCEmployerController {

    private EmployerDao employerDao;

    @Inject
    public SWCEmployerController(EmployerDao employerDao) {
        this.employerDao = employerDao;
    }

    @RequestMapping(value = "/employerList", method = RequestMethod.GET)
    public String displayEmployerList(Map<String, Object> model) {
        Employer[] employerList = employerDao.getAllEmployers();
        String[] tierList = employerDao.getEmployerTiers();
        String[] statusList = employerDao.getEmployerStatuses();
        model.put("employerList", employerList);
        model.put("tiers", tierList);
        model.put("statuses", statusList);
        return "displayEmployerList";
    }

    @RequestMapping(value = "/addEmployer", method = RequestMethod.POST)
    public String addEmployer(Map< String, Object> model,
            HttpServletRequest req,
            HttpServletResponse res) {
        String companyName = req.getParameter("companyName");
        String tier = req.getParameter("tier");
        String status = req.getParameter("status");
        String companyPhone = req.getParameter("companyPhone");
        String companyEmail = req.getParameter("companyEmail");
        String companyAddress = req.getParameter("companyAddress");
        Employer newEmployer = new Employer();

        newEmployer.setCompanyName(companyName);
        newEmployer.setTier(tier);
        newEmployer.setStatus(status);
        newEmployer.setCompanyPhone(companyPhone);
        newEmployer.setCompanyEmail(companyEmail);
        newEmployer.setCompanyAddress(companyAddress);

        //create the employer
        employerDao.addEmployer(newEmployer);

        int employerId = newEmployer.getEmployerId();


        String[] firstNameArray = req.getParameterValues("first_name[]");
        String[] lastNameArray = req.getParameterValues("last_name[]");
        String[] phoneArray = req.getParameterValues("phone[]");
        String[] emailArray = req.getParameterValues("email[]");
        String[] addressArray = req.getParameterValues("address[]");
        String[] noteArray = req.getParameterValues("note[]");

        for (int i = 0; i < firstNameArray.length; i++) {
            Contact contact = new Contact();
            contact.setEmployerId(employerId);
            contact.setFirstName(firstNameArray[i]);
            contact.setLastName(lastNameArray[i]);
            contact.setPhone(phoneArray[i]);
            contact.setEmail(emailArray[i]);
            contact.setAddress(addressArray[i]);
            contact.setNote(noteArray[i]);

            employerDao.addContact(contact);
            
        }

        return "redirect:employerList";

    }

    @RequestMapping(value = "removeEmployer", method = RequestMethod.GET)
    public String removeEmployer(@RequestParam("employerId") String employerId,
            Map<String, Object> model) {
        employerDao.removeEmployer(Integer.parseInt(employerId));
        return "redirect:employerList";
    }

    @RequestMapping(value = "editEmployerForm", method = RequestMethod.GET)
    public String displayEditEmployerForm(@RequestParam("employerId") String employerId,
            Map<String, Object> model) {
        Employer employer = employerDao.getEmployerById(Integer.parseInt(employerId));
        model.put("employer", employer);
        String[] tiers = employerDao.getEmployerTiers();
        String[] statuses = employerDao.getEmployerStatuses();
        Contact[] contacts = employerDao.getContactByEmployerId(Integer.parseInt(employerId));
        model.put("contacts", contacts);
        model.put("tiers", tiers);
        model.put("statuses", statuses);
        return "updateEmployerContact";
    }

    @RequestMapping(value = "editEmployer", method = RequestMethod.POST)
    public String editEmployer(@ModelAttribute("employer") Employer employer,
            Map<String, Object> model) {
        employerDao.editEmployer(employer);
        return "redirect:employerList";
    }

    //add a contact to an employer
    //needs to take into account the idea of using the employer id
    @RequestMapping(value = "/addContact", method = RequestMethod.POST)
    public String addContact(HttpServletRequest req) {

        Contact contact = new Contact();
        contact.setEmployerId(Integer.parseInt((req.getParameter("employerId"))));
        contact.setFirstName(req.getParameter("firstName"));
        contact.setLastName(req.getParameter("lastName"));
        contact.setPhone(req.getParameter("phone"));
        contact.setEmail(req.getParameter("email"));
        contact.setAddress(req.getParameter("address"));
        contact.setNote(req.getParameter("note"));

        employerDao.addContact(contact);

        return "redirect:editEmployerForm?employerId=" + contact.getEmployerId();
    }

    @RequestMapping(value = "removeContact", method = RequestMethod.GET)
    public String removeContact(@RequestParam("contactId") String contactId,
            Map<String, Object> model) {
        Contact contact = employerDao.getContactById(Integer.parseInt(contactId));
        employerDao.removeContact(Integer.parseInt(contactId));

        return "redirect:editEmployerForm?employerId=" + contact.getEmployerId(); //need to go back to modal
    }

}
