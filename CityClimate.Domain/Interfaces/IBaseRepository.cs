using System.Collections.Generic;
using CityClimate.Domain.Entities;

namespace CityClimate.Domain.Interfaces
{
    public interface IBaseRepository<T> where T : BaseEntity
    {
        T Get(int id);
        List<T> GetAll();
    }
}
