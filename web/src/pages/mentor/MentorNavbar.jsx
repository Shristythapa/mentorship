import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import "bootstrap/dist/js/bootstrap.bundle.min.js";

const MentorNavbar = () => {
  const navigate = useNavigate();
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const handleLogout = (e) => {
    e.preventDefault();
    localStorage.clear();
    navigate("/login");
  };
  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };

  const user = JSON.parse(localStorage.getItem("user"));
  const image = user.profileUrl;
  return (
    <div>
      <nav
        className="navbar navbar-expand-lg navbar-light justify-content-between p-3"
        style={{ backgroundColor: "#8535A1", maxWidth: "100vw" }}
      >
        <div className="mr-auto">
          <a
            className="navbar-brand"
            href="#"
            style={{ color: "#EEA025", fontSize: "30px" }}
          >
            Mentorship
          </a>
        </div>
        <div className="ms-auto container  justify-content-between w-80">
          <button
            className="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span className="navbar-toggler-icon"></span>
          </button>
        </div>

        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <ul className="navbar-nav mr-auto mt-2 mt-lg-0 me-5">
            <li className="nav-item me-5">
              <Link
                to={"/mentor/mentorSessionDashboard"}
                className="nav-link"
                style={{ color: "#EEA025", fontSize: "20px" }}
              >
                Sessions
              </Link>
            </li>

            <li className="nav-item me-5">
              <Link
                to={"/mentor/mentorArticleDashboard"}
                className="nav-link"
                style={{ color: "#EEA025", fontSize: "20px" }}
              >
                Articles
              </Link>
            </li>
          </ul>
          <div className="dropdown  ">
            <a
              href="#"
              className="d-flex align-items-center text-black text-decoration-none dropdown-toggle"
              id="dropdownUser1"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              <img
                src={image}
                alt="hugenerd"
                width="50"
                height="50"
                className="rounded-circle"
              ></img>
              <span
                className="d-none d-sm-inline mx-1"
                style={{ color: "#EEA025", fontSize: "20px" }}
              >
                {user.name}
              </span>
            </a>
            <ul className="dropdown-menu dropdown-menu-light text-small shadow">
              <li>
                <button
                  className="dropdown-item"
                  href="#"
                  onClick={handleLogout}
                >
                  Sign out
                </button>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </div>
  );
};

export default MentorNavbar;