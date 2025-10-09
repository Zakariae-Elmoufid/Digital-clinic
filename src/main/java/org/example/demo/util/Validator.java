package org.example.demo.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class Validator {

    public Validator() {
    }

    private final Map<String, String> errors = new HashMap<>();

    public void required(String field, String value, String message) {
        if (value == null || value.trim().isEmpty()) {
            errors.put(field, message);
        }
    }

    public void email(String field, String value, String message) {
        if (value == null || !Pattern.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$", value)) {
            errors.put(field, message);
        }
    }

    public void minLength(String field, String value, int length, String message) {
        if (value == null || value.length() < length) {
            errors.put(field, message);
        }
    }
    public void maxLength(String field, String value, int length, String message) {
        if (value == null || value.length() > length) {
            errors.put(field, message);
        }
    }

    public void regex(String field, String value, String regex, String message) {
        if (value == null || !Pattern.matches(regex, value)) {
            errors.put(field, message);
        }
    }

    public boolean hasErrors() {
        return !errors.isEmpty();
    }

    public Map<String, String> getErrors() {
        return errors;
    }

}
