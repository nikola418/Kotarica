﻿using Microsoft.EntityFrameworkCore;
using netCore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
//using System.Reflection;
using System.Threading.Tasks;

namespace netCore.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<Message> Message { get; set; }
        public DbSet<Notification> Notif { get; set; }
    }
}
