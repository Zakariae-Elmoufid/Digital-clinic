package org.example.demo.entity;
import jakarta.persistence.*;
import jakarta.validation.constraints.Pattern;

import java.util.List;


@Entity
@Table(name="doctors")
public class Doctor {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;

    @Pattern(regexp = "DOC[0-9]{4}", message = "the matricule must follow this form DOC1234")
    @Column(unique = true, nullable = false)
    private String matricule;


    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="specialite_id")
    private Specialite specialite;

    @OneToMany(mappedBy = "doctor")
    private List<Availability> availabilities;

    @OneToMany(mappedBy = "doctor")
    private  List<Appointment> appointments;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Specialite getSpecialite() {
        return specialite;
    }

    public void setSpecialite(Specialite specialite) {
        this.specialite = specialite;
    }

    public List<Availability> getAvailabilities() {
        return availabilities;
    }

    public void setAvailabilities(List<Availability> availabilities) {
        this.availabilities = availabilities;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }




}
