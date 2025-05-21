using FormApiBackend.Models;
using Microsoft.EntityFrameworkCore;

namespace FormApiBackend.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) 
            : base(options) { }

        public DbSet<Contact> Contacts { get; set; }
    }
}
